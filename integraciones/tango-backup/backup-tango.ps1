<#
  Backup de Tango Gestión a la nube + registro para el tablero "Backup Tango Trento".

  Corre en el servidor donde está el SQL Server de Tango (como administrador).
  Por cada base de Tango:
    1. Hace BACKUP DATABASE a un .bak con CHECKSUM.
    2. Verifica el archivo con RESTORE VERIFYONLY.
    3. Lo copia a la carpeta de Google Drive (Drive para escritorio lo sube solo).
    4. Agrega una fila a registro-backups.csv en esa misma carpeta.
  El tablero toma sus datos de ese CSV.

  Con -SoloLeerHistorial no hace backups: lee lo que SQL Server ya registró en
  msdb (útil si Tango ya hace sus propios backups) y lo vuelca al CSV.

  Ejemplos:
    .\backup-tango.ps1
    .\backup-tango.ps1 -Instancia "SERVIDOR\AXSQLEXPRESS" -Bases TRENTO_SA
    .\backup-tango.ps1 -SoloLeerHistorial -Dias 30
#>
param(
  # Instancia de SQL Server de Tango. AXSQLEXPRESS es la que instala Tango por defecto.
  [string]$Instancia = "localhost\AXSQLEXPRESS",
  # Bases a respaldar. Vacío = todas las bases de usuario de la instancia.
  [string[]]$Bases = @(),
  # Carpeta local donde SQL Server escribe el .bak (la cuenta del servicio SQL necesita permiso).
  [string]$CarpetaLocal = "C:\BackupsTango",
  # Carpeta sincronizada con la nube (Google Drive para escritorio, OneDrive, etc.).
  [string]$CarpetaNube = "G:\Mi unidad\Backups Tango",
  [string]$Destino = "Google Drive",
  # Días que se guardan los .bak en la nube y en la carpeta local.
  [int]$Retencion = 15,
  [switch]$SoloLeerHistorial,
  [int]$Dias = 30
)

$ErrorActionPreference = "Stop"
$csv = Join-Path $CarpetaNube "registro-backups.csv"
$cs = "Server=$Instancia;Database=master;Integrated Security=True;TrustServerCertificate=True"

function Invoke-Sql([string]$sql, [int]$timeout = 3600) {
  $cn = New-Object System.Data.SqlClient.SqlConnection $cs
  $cn.Open()
  try {
    $cmd = $cn.CreateCommand(); $cmd.CommandText = $sql; $cmd.CommandTimeout = $timeout
    $t = New-Object System.Data.DataTable
    $t.Load($cmd.ExecuteReader())
    return ,$t
  } finally { $cn.Close() }
}

function Add-Registro($ts, $base, $tipo, $estado, $mb, $min, $verificado, $nota) {
  [pscustomobject]@{
    ts = $ts.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.000Z")
    base = $base; tipo = $tipo; estado = $estado
    mb = if ($mb -ne $null) { [math]::Round($mb) } else { "" }
    min = if ($min -ne $null) { [math]::Round($min) } else { "" }
    destino = $Destino; verificado = [bool]$verificado; nota = $nota
    equipo = $env:COMPUTERNAME
  } | Export-Csv -Path $csv -Append -NoTypeInformation -Encoding UTF8
}

New-Item -ItemType Directory -Force -Path $CarpetaLocal, $CarpetaNube | Out-Null

if (-not $Bases.Count) {
  $Bases = (Invoke-Sql "SELECT name FROM sys.databases WHERE database_id > 4 AND state_desc = 'ONLINE' ORDER BY name").Rows | ForEach-Object { $_.name }
}
if (-not $Bases.Count) { throw "No se encontraron bases en $Instancia. Revisá el nombre de la instancia." }

if ($SoloLeerHistorial) {
  $lista = ($Bases | ForEach-Object { "N'" + $_.Replace("'", "''") + "'" }) -join ","
  $hist = Invoke-Sql @"
SELECT bs.database_name, bs.backup_start_date, bs.backup_finish_date, bs.type,
       bs.backup_size / 1048576.0 AS mb, bs.has_backup_checksums, bmf.physical_device_name
FROM msdb.dbo.backupset bs
JOIN msdb.dbo.backupmediafamily bmf ON bs.media_set_id = bmf.media_set_id
WHERE bs.database_name IN ($lista) AND bs.backup_start_date >= DATEADD(day, -$Dias, GETDATE())
ORDER BY bs.backup_start_date
"@
  foreach ($r in $hist.Rows) {
    $tipo = @{ D = "Completo"; I = "Diferencial"; L = "Log" }[[string]$r.type]
    $min = ($r.backup_finish_date - $r.backup_start_date).TotalMinutes
    Add-Registro $r.backup_finish_date $r.database_name $tipo "ok" $r.mb $min $false ("Historial SQL: " + $r.physical_device_name)
  }
  Write-Host "$($hist.Rows.Count) backups del historial agregados a $csv"
  exit 0
}

$huboFalla = $false
foreach ($base in $Bases) {
  $inicio = Get-Date
  $archivo = Join-Path $CarpetaLocal ("{0}_{1:yyyyMMdd_HHmm}.bak" -f $base, $inicio)
  $mb = $null; $verificado = $false
  try {
    $b = $base.Replace("]", "]]"); $f = $archivo.Replace("'", "''")
    Invoke-Sql "BACKUP DATABASE [$b] TO DISK = N'$f' WITH INIT, CHECKSUM, NAME = N'Backup Tango $b'" | Out-Null
    $mb = (Get-Item $archivo).Length / 1MB
    Invoke-Sql "RESTORE VERIFYONLY FROM DISK = N'$f' WITH CHECKSUM" | Out-Null
    $verificado = $true
    Copy-Item $archivo -Destination $CarpetaNube -Force
    $copia = Get-Item (Join-Path $CarpetaNube (Split-Path $archivo -Leaf))
    if ($copia.Length -ne (Get-Item $archivo).Length) { throw "La copia en la nube no tiene el mismo tamaño que el original." }
    Add-Registro (Get-Date) $base "Completo" "ok" $mb ((Get-Date) - $inicio).TotalMinutes $false "Archivo verificado con RESTORE VERIFYONLY"
    Write-Host "OK  $base  $([math]::Round($mb)) MB"
  } catch {
    $huboFalla = $true
    $estado = if ($verificado) { "parcial" } else { "fallo" }
    Add-Registro (Get-Date) $base "Completo" $estado $mb ((Get-Date) - $inicio).TotalMinutes $false $_.Exception.Message
    Write-Warning "FALLÓ  $base : $($_.Exception.Message)"
  }
}

# Limpieza de copias viejas (solo .bak; el CSV se conserva)
$limite = (Get-Date).AddDays(-$Retencion)
Get-ChildItem $CarpetaLocal, $CarpetaNube -Filter *.bak | Where-Object LastWriteTime -lt $limite | Remove-Item -Force

if ($huboFalla) { exit 1 }
