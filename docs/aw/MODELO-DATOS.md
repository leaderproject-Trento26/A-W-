# Modelo de datos de A+W Business (insumo para el MCP)

Fuente principal: manual *ALFAK_Modelo_de_datos* (2017), complementado con *Gestión de Documentos*,
*Archivar documentos* y *Estadísticas*.

> **ALFAK = A+W Business.** ALFAK es el nombre anterior del mismo sistema; los manuales usan ambos.

## Datos técnicos confirmados
| Dato | Valor | Fuente |
|---|---|---|
| Motor de base de datos | **Microsoft SQL Server**: el manual usa *Management Studio* y `CONVERT(varchar(max), …)` | Modelo de datos |
| Esquema de las tablas | **`SYSADM`** (ej.: `SYSADM.KU_KUNDEN`) | Modelo de datos |
| Nombres de tablas | En **alemán**, con prefijo de módulo (`KU_`, `BA_`, `BW_`…) | Modelo de datos |
| Documentación completa de tablas y campos | Viene con cada instalación: **Inicio → Programas → Albat + Wirsam → Documentation** | Modelo de datos |
| Base de archivo | Cada año se crea una **base de datos de archivo** aparte, y los documentos viejos se mueven allí | Archivar documentos |
| Campos binarios | Algunos campos de texto están en binario; se leen con `CONVERT(varchar(max), campo)` | Modelo de datos |

## Tablas por módulo

### KU: Clientes (*Kunden*)
| Tabla | Contenido |
|---|---|
| `SYSADM.KU_KUNDEN` | Ficha de cliente (campo binario `KURZINFO` = "Info") |

Las **filiales** (direcciones de entrega o facturación distintas) son también fichas de cliente
asociadas a un cliente principal.

### LI: Proveedores (*Lieferanten*)
| Tabla | Contenido |
|---|---|
| `SYSADM.LI_LIEFERANTEN` | Ficha de proveedor |

### BA: Productos
| Tabla | Contenido |
|---|---|
| `SYSADM.BA_PRODUKTE` | Ficha de producto: matchcode, tipo, grupo, familia |
| `SYSADM.BA_PRODUKTE_BEZ` | Descripción y unidad del producto |
| `SYSADM.BA_STUKL` | Lista de piezas (componentes) |
| `SYSADM.BA_STUKL_BEARB` | Manufacturas o procesos de la lista de piezas |
| `SYSADM.BA_STUKL_MODELL` | Formas |
| `SYSADM.BA_STUKL_SPROSSEN` | Barrotillos |
| `SYSADM.BA_LAGMA` | Medidas de hoja entera (láminas) |

### PR: Precios · RB: Descuentos (**sensibles**)
| Tabla | Contenido |
|---|---|
| `PR_PREIS` / `PR_PREISKPF` | Precio estándar / cabecera de tabla de precio |
| `PR_KG_PREIS` / `PR_KG_PREISKPF` | Precios por grupo de clientes |
| `PR_KU_PREIS` / `PR_KU_PREISKPF` | Precios por cliente |
| `RB_RABATT` | Descuentos (se combina con las siguientes) |
| `RB_KU_WGR`, `RB_KU_PROD` | Descuento de cliente por familia / por producto |
| `RB_KG_WGR`, `RB_KG_PROD` | Descuento de grupo de clientes por familia / por producto |

Todas llevan el prefijo `SYSADM.`. **Recomendación:** que el MCP *no* exponga estas tablas al principio.

### BW: Documentos (lo central)
Hay 5 tipos de documento maestro y **todos usan la misma estructura de tablas**:

| Documento | Significado | Código `XXXX` |
|---|---|---|
| Oferta | Cotización | `ANGEB` |
| Pedido | Venta | `AUFTR` |
| Abono | Nota de crédito | `GUTSCH` |
| Consulta | Presupuesto de compra | `ANFR` |
| Encargo | Compra | `BEST` |

| Tabla | Contenido |
|---|---|
| `SYSADM.BW_XXXX_KOPF` | Cabecera: cliente, fecha de entrega, referencia, estatus, ruta… |
| `SYSADM.BW_XXXX_POS` | Posiciones (ítems): producto, piezas, ancho, alto, precio |
| `SYSADM.BW_XXXX_STKL` | Lista de piezas de cada posición: composición, procesos |
| `SYSADM.BW_XXXX_HIST` | Historia del documento (cambios de estatus) |

Ejemplo, pedidos de venta: `BW_AUFTR_KOPF`, `BW_AUFTR_POS`, `BW_AUFTR_STKL`, `BW_AUFTR_HIST`.

Los "Tipos de documento" (Reclamación, Expedición parcial…) que vimos en la captura son
**subtipos** dentro de estos 5 documentos maestros.

### KA: Varios (tablas de apoyo)
| Tabla | Contenido |
|---|---|
| `KA_ZAHLWED` | Condiciones de pago |
| `KA_ZAHLWEG` | Formas de pago |
| `KA_MWST` | IVA |
| `KA_BRANCHEN` | Sectores |
| `KA_KUNDENGRPN` | Grupos de cliente |
| `KA_WGR` | Familias de producto |
| `KA_OBJEKT` | Obras |

### Sin nombre de tabla todavía
- Expedición: rutas, vehículos, choferes, condiciones de expedición, caballetes.
- Gestión de números, Info Pedidos y Estadística de ventas.
- Tipos de documento.

Para encontrarlas: la documentación de la instalación, o la consulta de descubrimiento que está más abajo.

## ✅ Estatus reales de Trento (captura de GN pedido)
- La base de datos se llama **`TRENTO_BA`**.
- Trento usa una numeración **de tipo B** (cientos), personalizada con estatus de planta (**BDE**):

| Estatus | Significado |
|---|---|
| 430 | Lote organizado |
| 460 | BDE – Cortado |
| 485 | BDE – Templado |
| 540 | **Pedido listo para envío**: la clave para Trento Entregas |
| 990 | Autorización de cancelación (probablemente anulado) |

La lista completa se obtiene de la gestión de estatus. El esquema A que sigue queda solo como referencia.

## Flujo de estatus del Pedido: ⚠️ hay dos esquemas en los manuales
Los manuales traen **dos numeraciones distintas**. Cada empresa configura la suya, así que **hay que
confirmar cuál usa Trento**: basta mirar el estatus de un pedido real, o la tabla `BW_AUFTR_HIST`.

### Esquema A: flujo de ventas "VITRUM" (1 a 170)
Fuente: *Resumen de flujo de programa*. Coincide con los números que usan *Archivar* y *Estadísticas*
(100, 110, 120), y habla de "guía de remisión", un término latinoamericano.
**Es el candidato más probable para Trento.**

| Estatus | Significado | Quién lo cambia |
|---|---|---|
| 1 | Documento creado | Automático |
| 2 | Documento modificado | Automático |
| 10 | Recibo de caja pendiente (pago CONTADO) | VENTAS, con el botón Estatus |
| 12 | Revisión de medidas | CAJA, al imprimir el recibo |
| 14 | Medidas revisadas | VENTAS / CAJA |
| 15 | Hoja de producción editada (el pedido queda **bloqueado**) | Al imprimir la hoja de taller |
| 30 | Transmisión a compras | Sesión |
| 35 | Liberado para producción | |
| 40 | Transmisión a producción (XOPT o ALCIM) | Sesión "Carga GN" |
| 43–46 | ALCIM: lote disuelto, planificado, organizado, liberado | Producción |
| 47–49 | Barcoding: cortado, pulido, perforado, templado | Lectura de código de barras |
| 66 | **Fin de producción** | FÁBRICA |
| 67 | Control de calidad | FÁBRICA |
| 68 | **Listo para despacho** | DESPACHO |
| 71 | **Guía de remisión** (albarán) impresa | CAJA |
| 72 | Sacado de almacén | Al imprimir la guía, si hay productos de stock |
| 95 | Factura editada (exige guía previa) | CAJA |
| 100 | Transmisión a contabilidad | Sesión |
| 110 | Transmisión a estadísticas | Sesión |
| 120 | Transmisión a archivo | Sesión |
| 170 (o 952) | Límite de crédito excedido | Automático |

Estatus de la oferta: 1 creada · 2 modificada · 4 editada · 23 rechazada · 25 aceptada · 27 copiada a pedido · 120 archivada.

### Esquema B: estándar genérico (1 a 900)
Fuente: *Gestión de Documentos*.

| Estatus | Significado |
|---|---|
| 1 | Documento creado |
| 20 | Documento modificado |
| 180 | Hoja de taller |
| 200 | Confirmación de pedido impresa |
| 235 | **Transmitir a Tango** |
| 240 | **Importado a Tango** |
| 390 | Liberado para producción |
| 450 | Lote liberado |
| 540 | **Fin de producción / listo para envío** |
| 600 | **Albarán (remito) de entrega** |
| 750 | Factura impresa |
| 800 | Transmisión a contabilidad |
| 850 | Transmisión a estadísticas |
| 900 | Transmisión a archivo |

> **Tango** es un sistema contable/de gestión externo: este flujo estaba adaptado a una instalación que
> integra con Tango. Hay que confirmar si Trento lo usa.

Otros flujos:
- **Encargo (compra):** 200 impreso → 259 entrada parcial → 260 entrada completa → 265 control de factura → 800 → 850 → 900.
- **Oferta:** 1 → 20 → 200 editada.
- **Abono:** 750 editado → 800 → 850 → 900.

### Puntos de estatus y otros datos de negocio
- Los números 501, 531, 541… y 700 que aparecen en *Archivar* y en *Límite de crédito* son **puntos de estatus**:
  reglas que dicen qué estatus asignar ante cada evento. No son estatus de documento.
- **Info Pedidos** lee los pedidos en estatus 1 a 109 directamente. Los de estatus 110 o más los lee
  de una tabla de estadística que se llena al transmitir.
- **Límite de crédito:** el campo "Pedidos" del cliente suma los pedidos entre estatus 1 y 800 del esquema B.
  El "Retorno de saldos" lo trae la contabilidad externa.
- **Grupos de usuario** mencionados: VENTAS, CAJA, FÁBRICA, DESPACHO y SISTEMAS.

## Almacén (manual *AWB Almacén*)
- Cada ubicación combina **4 niveles** de clasificación.
- El vidrio se controla **por hoja entera** (tabla `BA_LAGMA`, sesión "Medidas H.E.").
  Los herrajes y consumibles se controlan por pieza.
- Sesiones: Gestión almacén (stock) · Movimientos (entradas, salidas, transferencias) · Consultas (historial) ·
  Búsqueda almacén (stock, reservado y encargado) · **Encargo almacén** (compra automática).
- Compra automática: `a comprar = mínimo − (stock − reservado + encargado)`, redondeado al factor de compra.
- El inventario admite hasta 5.000 entradas por lista, y cada lista lleva una fecha distinta.

## Producción: Gerente de producción (AWB Pro)
- Solo ve los pedidos **ya transmitidos a producción**, normalmente con "Carga GN".
- Se trabaja por **tareas**, con estos estados: planificado en general → planificado en detalle →
  optimizada → aprobado (códigos de corte generados) → acabado.
- Imprime la lista de **ocupación de caballetes**, los planos de corte y las etiquetas.
  Las etiquetas de corte se reutilizan para expedición.

## Consulta de descubrimiento (para cuando haya acceso de solo lectura)
Son consultas estándar de SQL Server que **solo leen la lista de tablas y columnas**, no los datos:

```sql
-- 1. Todas las tablas del esquema SYSADM, por módulo
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'SYSADM' ORDER BY TABLE_NAME;

-- 2. Columnas de la cabecera de pedidos
SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'SYSADM' AND TABLE_NAME = 'BW_AUFTR_KOPF' ORDER BY ORDINAL_POSITION;

-- 3. Pistas para expedición (rutas, vehículos, choferes, caballetes)
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'SYSADM'
  AND (TABLE_NAME LIKE '%TOUR%' OR TABLE_NAME LIKE '%FAHR%' OR TABLE_NAME LIKE '%GESTELL%'
       OR TABLE_NAME LIKE '%VERSAND%' OR TABLE_NAME LIKE '%LKW%');
```

En el patrón de búsqueda, los términos alemanes significan: *Tour* = ruta, *Fahrer/Fahrzeug* =
chofer/vehículo, *Gestell* = caballete, *Versand* = envío, *LKW* = camión.

## Primeras preguntas que debería responder el MCP
Relacionadas con **Trento Entregas**:
1. Pedidos **listos para despacho** (estatus 68 en el esquema A, o 540 en el B) por fecha de entrega y ruta.
2. Pedidos de una **ruta y fecha**, con cliente, piezas, m² y peso.
3. Carga asignada a cada **vehículo o chofer** frente a su capacidad.
4. **Caballetes** que están en clientes y desde cuándo.
5. Historial de estatus de un pedido (`BW_AUFTR_HIST`): ¿cuándo se produjo y cuándo se entregó?
6. **Reclamaciones** abiertas por cliente o producto.
