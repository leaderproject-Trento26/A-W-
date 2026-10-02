# Guía: primera conexión de lectura a la base de A+W

> Etapa 2 del plan: **prueba de conexión**. El objetivo es solo **mirar**: confirmar que el acceso funciona,
> ver qué tablas hay y responder la primera pregunta de negocio:
> **¿Ventas carga los presupuestos como Oferta en A+W?**
> Nada de esto modifica datos.

## Reglas de seguridad (leer antes)
1. **Solo `SELECT`.** Nunca ejecutar `UPDATE`, `DELETE`, `INSERT`, `DROP`, `ALTER` ni `TRUNCATE`.
   Si una consulta trae alguna de esas palabras, **no la ejecutes**.
2. Usa siempre `WITH (NOLOCK)` o `TOP`, como en las consultas de abajo. Así la consulta no traba a los
   usuarios que están trabajando en A+W.
3. Si puedes, hazlo **fuera de las horas pico**.
4. **No me mandes datos de clientes ni precios.** Para estas primeras consultas alcanza con nombres de
   columnas y cantidades.

## Paso 1: tener la herramienta
Se usa **SQL Server Management Studio (SSMS)**, el programa gratuito de Microsoft para consultar SQL Server.
- Busca en el menú Inicio de Windows "**SQL Server Management Studio**".
- Si no está instalado, pídeselo a sistemas, o descárgalo de la página oficial de Microsoft.

## Paso 2: datos de conexión
Al abrir SSMS aparece la ventana **Conectar al servidor**. Necesitas:

| Campo | Qué poner | Dónde conseguirlo |
|---|---|---|
| Tipo de servidor | Motor de base de datos | Viene por defecto |
| Nombre del servidor | Ej.: `SERVIDOR\INSTANCIA` | Pregúntale a sistemas. También puede aparecer en la configuración de conexión de A+W, en la pantalla de inicio de sesión ("Conexión: A+W") |
| Autenticación | *Autenticación de Windows*, o *Autenticación de SQL Server* con usuario y clave | Sistemas: es el permiso de lectura que te dieron |

Luego: **Conectar**.

## Paso 3: abrir la base de Trento
1. En el panel izquierdo despliega **Bases de datos** y busca **`TRENTO_BA`**.
2. Haz clic derecho sobre `TRENTO_BA` → **Nueva consulta**.
3. Pega una consulta, presiona **F5** (Ejecutar) y mira el resultado abajo.

## Paso 4: consultas de reconocimiento
Ejecútalas **de a una**. Para mandarme el resultado: clic derecho sobre la grilla de resultados →
**Guardar resultados como…** (CSV), o una captura.

### Consulta 1: ¿qué tablas hay? (solo nombres)
```sql
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'SYSADM'
ORDER BY TABLE_NAME;
```
Mándame la lista completa. No contiene datos de nadie.

### Consulta 2: ¿qué columnas tienen las ofertas? (solo nombres)
```sql
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'SYSADM'
  AND TABLE_NAME IN ('BW_ANGEB_KOPF', 'BW_ANGEB_HIST')
ORDER BY TABLE_NAME, ORDINAL_POSITION;
```

### Consulta 3: ¿cuántas ofertas y cuántos pedidos hay? (solo cantidades)
```sql
SELECT 'Ofertas' AS documento, COUNT(*) AS cantidad FROM SYSADM.BW_ANGEB_KOPF WITH (NOLOCK)
UNION ALL
SELECT 'Pedidos', COUNT(*) FROM SYSADM.BW_AUFTR_KOPF WITH (NOLOCK);
```
- Si hay **muchos pedidos y casi ninguna oferta**, los presupuestos **no se cargan en A+W**.
  Ese es el primer punto a resolver.
- Si hay muchas ofertas, con la consulta 2 armo la siguiente: ofertas por estatus y por mes.

## Paso 5: qué hago yo con esto
Con las columnas reales escribo las consultas precisas:
- Ofertas por estatus.
- Tiempo entre "creada" y "presentada".
- Conversión a pedido.

Esas consultas son la base del **tablero comercial** y, más adelante, del **MCP**.

## Cómo puede ayudar Claude directamente
| Opción | Cómo funciona |
|---|---|
| **A. Tú ejecutas y me mandas el resultado** | La más simple. Sirve para empezar |
| **B. Claude Code en tu PC de Trento** | Abres una sesión **local** de Claude Code en esa PC. Yo propongo las consultas, tú las apruebas y las ejecuto con `sqlcmd`. Siempre solo lectura |
| **C. MCP** | Etapa final: un conector de solo lectura con usuario propio. Claude consulta solo, dentro de límites definidos |
