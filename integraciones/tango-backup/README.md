# Backup de Tango Gestión a la nube

Script para el servidor de Tango que hace el backup de la base, lo verifica, lo sube a la nube y deja un registro (`registro-backups.csv`) que alimenta el tablero **Backup Tango Trento**.

## Cómo queda conectado

```
SQL Server de Tango ──backup.ps1──► .bak verificado ──► carpeta de Google Drive ──► nube
                                     └─► registro-backups.csv ──► tablero de backups
```

El tablero no puede entrar directo al servidor de Tango (corre en el navegador y el servidor está en la red de la empresa). Por eso el puente es el CSV en Google Drive: el script lo escribe y el tablero lo lee.

## Instalación (en el servidor de Tango, como administrador)

1. Instalar **Google Drive para escritorio** con la cuenta de la empresa y crear la carpeta `Mi unidad\Backups Tango`.
2. Copiar `backup-tango.ps1` a `C:\Scripts\`.
3. Averiguar el nombre de la instancia de SQL de Tango: en el servidor, abrir *Servicios* y buscar `SQL Server (AXSQLEXPRESS)` o similar. El valor es `NOMBRE-PC\AXSQLEXPRESS`.
4. Darle a la cuenta del servicio de SQL Server permiso de escritura en `C:\BackupsTango`.
5. Probarlo a mano en PowerShell como administrador:
   ```powershell
   powershell -ExecutionPolicy Bypass -File C:\Scripts\backup-tango.ps1 -Instancia "NOMBRE-PC\AXSQLEXPRESS"
   ```
6. Programarlo todas las noches (después del cierre, cuando nadie usa Tango):
   ```powershell
   schtasks /Create /TN "Backup Tango" /SC DAILY /ST 23:00 /RU SYSTEM /RL HIGHEST `
     /TR "powershell -ExecutionPolicy Bypass -File C:\Scripts\backup-tango.ps1 -Instancia NOMBRE-PC\AXSQLEXPRESS"
   ```
   Si corre como `SYSTEM`, la unidad de Google Drive puede no estar montada: en ese caso usar `/RU` con el usuario que tiene Drive abierto.

## Si Tango ya hace sus propios backups

Para no duplicar, el script puede leer lo que SQL Server ya registró y solo volcarlo al CSV:

```powershell
.\backup-tango.ps1 -SoloLeerHistorial -Dias 30
```

## Columnas del CSV

`ts` (UTC), `base`, `tipo` (Completo / Diferencial / Log), `estado` (ok / parcial / fallo), `mb`, `min`, `destino`, `verificado` (prueba de restauración completa), `nota`, `equipo`.
