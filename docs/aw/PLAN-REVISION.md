# Plan de revisión de A+W (Trento)

**Objetivo:** entender qué módulos y datos usa Trento en A+W y preparar el terreno para el **MCP de solo lectura**
que conectará Claude a la base de datos.

**Cómo funciona:** tú sacas la información de A+W (capturas y exports) y me la pasas.
Yo la analizo y anoto lo encontrado en [`HALLAZGOS.md`](HALLAZGOS.md).
Avanzamos una fase a la vez.

---

## Antes de empezar: cómo sacar información de A+W

### A. Captura de pantalla
- **Windows:** `Win + Shift + S`, seleccionas la zona y la pegas aquí en el chat con `Ctrl + V`.
- Captura siempre la ventana completa, con el menú de la izquierda y las pestañas de abajo visibles.
  Así sé en qué parte del sistema estás.

### B. Exportar una tabla (grilla) a Excel
Prueba en este orden hasta que uno funcione:
1. **Clic derecho** sobre la grilla → busca *Exportar*, *Excel* o *Copiar*.
2. Revisa el menú superior **Edición**, que a veces trae *Exportar* o *Copiar todo*.
3. Haz clic en una celda, presiona `Ctrl + A` y luego `Ctrl + C`, abre Excel y pega con `Ctrl + V`.
4. Si nada funciona, manda una captura de la grilla y veo otra forma.

Guarda el archivo como `.xlsx` o `.csv`, con un nombre que diga qué es.
Ejemplo: `fase2-productos.xlsx`.

### C. Cuidado con los datos
- **Precios, costos y datos de clientes** (nombres, teléfonos, direcciones): si no estás seguro de poder
  compartirlos, borra o reemplaza esas columnas antes de enviarlas.
- Para entender la estructura bastan **10 a 20 filas de ejemplo**, no hace falta exportar todo.
- **No cambies nada en A+W.** Solo mira y exporta. No uses los botones *Nuevo*, *Borrar* ni *Grabar*,
  ni marques o desmarques casillas.

---

## Fase 1: Mapa del sistema (qué hay)
**Meta:** conocer todos los menús y la versión.

| # | Paso | Qué me envías |
|---|------|---------------|
| 1.1 | Menú **Ayuda → Acerca de** (o *Info*) | Captura con la versión de A+W |
| 1.2 | En la barra inferior izquierda, haz clic en la **flechita ▾** junto a los íconos pequeños y muestra todos los módulos | Captura de la lista completa |
| 1.3 | En **Datos básicos**, abre (con el **+**) cada carpeta: General, Productos, Precios, Almacén, Partner, Expedición, Producción, Documentos, Finanzas, Empresa | Una captura por carpeta abierta |
| 1.4 | Haz clic en el módulo **Documentos** (abajo a la izquierda) y abre sus carpetas | Captura |
| 1.5 | Haz clic en el módulo **Producción** y abre sus carpetas | Captura |

**Resultado:** el mapa completo de módulos de Trento, que registro en `HALLAZGOS.md`.

## Fase 2: Datos maestros (con qué trabajan)
**Meta:** conocer los catálogos base.

| # | Pantalla | Qué me envías |
|---|----------|---------------|
| 2.1 | Productos (vidrios, láminas, perfiles) | Export de 20 filas |
| 2.2 | Almacén (almacenes y ubicaciones) | Export |
| 2.3 | Partner del mercado → clientes | Export de 10 filas, **anonimizado** |
| 2.4 | Expedición (rutas, vehículos, zonas de entrega) | Export o capturas. **Clave para la app Trento Entregas** |
| 2.5 | Documentos → Tipos de documento y Datos documentos | ✅ Tipos de documento ya recibido |

## Fase 3: Documentos (el día a día)
**Meta:** entender el flujo **pedido → producción → expedición → factura**.

| # | Pantalla | Qué me envías |
|---|----------|---------------|
| 3.1 | Pestaña **Pedido**: lista de pedidos de una semana | Export con columnas y estados |
| 3.2 | Un pedido abierto completo (cabecera y posiciones) | Capturas de cada pestaña del pedido |
| 3.3 | **GN pedido** (¿qué es? lo averiguamos) | Captura |
| 3.4 | **Compra**: lista de compras | Export de 10 filas |
| 3.5 | **Factura TPS** | Captura, sin montos si es sensible |
| 3.6 | Un documento de **Expedición parcial** o de entrega | Captura |

## Fase 4: Producción
| # | Pantalla | Qué me envías |
|---|----------|---------------|
| 4.1 | Lista de órdenes o pedidos de producción | Export |
| 4.2 | Estados por los que pasa una orden | Capturas |

## Fase 5: Informes
| # | Pantalla | Qué me envías |
|---|----------|---------------|
| 5.1 | Pestaña **Crystal Reports**: lista de informes disponibles | Captura |
| 5.2 | Los 3 informes que más usan | PDF o export de cada uno |

## Fase 6: Preparación del MCP (conexión directa a la base de datos)
**Meta:** llegar con todo listo para construir el MCP de **solo lectura**.

**Preguntas para el área de sistemas:**
1. ¿Qué motor de base de datos usa A+W? (probablemente **Microsoft SQL Server**) ¿Qué versión?
2. ¿Nombre del servidor e instancia, y nombre de la base de datos?
3. ¿Pueden crear un **usuario de solo lectura** (por ejemplo `claude_lectura`) con acceso solo a `SELECT`?
4. ¿Desde qué PC de la red se permitirá la conexión?
5. ¿A+W tiene documentación del modelo de datos (tablas) o soporte al que podamos preguntar?

**Qué haré yo con lo de las fases 1 a 5:**
- Un **diccionario de datos**: pantalla → campo → tabla y columna (cuando las conozcamos).
- La lista de **consultas** que el MCP debe responder (ejemplo: "pedidos pendientes de entrega hoy").
- El diseño del MCP: herramientas, consultas permitidas y medidas de seguridad.

---

## Estado

| Fase | Estado |
|------|--------|
| 0. Manuales | ✅ 30 manuales leídos y resumidos ([`MANUALES.md`](MANUALES.md)) |
| 1. Mapa del sistema | 🟡 En curso (1 captura recibida) |
| 2. Datos maestros | 🟡 Tipos de documento recibido; estructura conocida por los manuales |
| 3. Documentos | 🟡 Flujo y estatus conocidos por los manuales; **falta confirmar el esquema de Trento** |
| 4. Producción | 🟡 Conocida por los manuales; falta confirmar qué módulos tienen |
| 5. Informes | ⚪ Pendiente |
| 6. Preparación MCP | 🟡 Motor (SQL Server), esquema (`SYSADM`) y tablas principales conocidos ([`MODELO-DATOS.md`](MODELO-DATOS.md)) |

## Próximos pasos prioritarios (actualizado tras leer los manuales)
1. **Documentación de tablas de la instalación.** En la PC donde está A+W, abre
   **Inicio → Programas → Albat + Wirsam → Documentation**. Es el diccionario oficial de tablas y
   campos, la pieza más valiosa para el MCP. Mándame lo que encuentres (PDF, captura de la carpeta, etc.).
2. **Esquema de estatus.** Abre un pedido reciente que ya se haya entregado y mándame una captura
   de su **historia** (en el pedido: Funciones → Historia). Así sé qué numeración de estatus usa Trento.
3. **Expedición real.** Mándame capturas de *Datos básicos → Expedición → Rutas*, *Vehículos* y *Chofer*,
   y de *Producción → Expedición → Lista de rutas*.
4. Fase 1: Ayuda → Acerca de, y la lista de módulos.
