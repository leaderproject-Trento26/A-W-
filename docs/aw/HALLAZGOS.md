# Hallazgos de la revisión de A+W

Registro de todo lo que vamos descubriendo. Cada hallazgo indica su **fuente** (captura o export en `docs/aw/`).

## Sistema
- **Producto:** **A+W Business**, antes llamado **ALFAK**, del fabricante Albat + Wirsam.
  Versión exacta: _pendiente (Fase 1.1)_; el manual de Expedición es de la versión 6.
- **Base de datos:** **Microsoft SQL Server**, esquema `SYSADM`. ✅ Confirmado por el manual *Modelo de datos*.
- **Conexión mostrada:** `A+W`.
- Puede haber **módulos de producción** instalados: Gerente de producción (AWB Pro), ALCIM, XOPTON y Barcoding.
- Integración contable externa: hay transmisión a contabilidad y retorno de saldos.
  Un flujo de estatus menciona **Tango**; está pendiente confirmar si Trento lo usa.

## Pantalla "GN pedido" (captura 2)
Ruta: Documentos → Pedido → GN pedido. La captura no se guarda en el repo porque muestra nombres
reales de clientes.

- **Empresa:** `TRENTO` · **Base de datos:** `TRENTO_BA`. Es el nombre de la base en SQL Server.
- La GN "SEPTIEMBRE" tiene 309 pedidos. Los números de pedido son de 8 dígitos (ej. `12006783`).
- Columnas de la grilla (vista "Registro"): Números, Nr. encargo, CP Proveedor, Fecha entrega,
  Nr. pedido, Cliente/proveed., Nombre, Matchcode, **Estatus**, Fecha 1 regist.
- **Estatus reales de Trento** (confirman un esquema de tipo B, de 1 a 900 o más, personalizado):

| Estatus | Texto en pantalla |
|---|---|
| 430 | LOTE ORGANIZADO |
| 460 | BDE - CORTADO |
| 485 | BDE - TEMPLADO |
| 540 | Pedido listo para envio |
| 990 | Autorización de cancela… (texto cortado; probablemente pedido anulado) |

  **BDE** (*Betriebsdatenerfassung*) es la captura de datos de planta: los pedidos cambian de estatus
  al escanearlos en cada máquina. Es decir, Trento **sí tiene seguimiento de producción por código de barras**.
- **Sesiones del menú Documentos → Pedido:** GN pedido, Introd. pedidos, Expedición parcial,
  Edición pedido, Control de ofertas, Transmisión contabilidad, Import./export. Pagos, Diario,
  Administración de pagos a cuenta, Pedidos pago anticip., Transmisión encargo,
  Transmisión archivo-estadíst., Búsqueda, Importación, Recibos bancarios, Recalcular,
  Gestión de obras, **Factura TPS**, Consulta rápida, Comprobantes de garantía.

## Documentación recibida
Se recibieron 30 manuales; el resumen está en [`MANUALES.md`](MANUALES.md).
Las tablas, los estatus y las consultas para el MCP están en [`MODELO-DATOS.md`](MODELO-DATOS.md).

## Módulos visibles
Fuente: `capturas/01-datos-basicos-tipos-documento.png`

- **Menú lateral:** Datos básicos, Documentos, Producción (hay más íconos sin identificar).
- **Carpetas de Datos básicos:** General, Productos, Precios, Almacén, Partner del mercado, Expedición,
  Producción, Documentos, Finanzas, Empresa, Textos, Formularios, CEKAL, Distintivo CE, B2B.
- **Pestañas abiertas:** Pedido, Factura TPS, Compra, GN pedido, Pedido, Crystal Reports,
  Datos documentos, Tipos documento.
- **Certificaciones:** CEKAL (certificación francesa de vidrio aislante) y Distintivo CE (marcado CE)
  sugieren que fabrican vidrio aislante o templado.

## Tipos de documento
Ruta: Datos básicos → Documentos → Tipos documento. Fuente: `capturas/01-datos-basicos-tipos-documento.png`

| Tipo de documento | Bloqueado | En uso |
|---|---|---|
| Reservación de valor | Sí | No |
| Reclamación | No | **Sí** |
| Expedición parcial | No | **Sí** |
| Pedido de producción | No | **Sí** |
| Pedido de serie | Sí | No |
| Pedido de contrato | No | **Sí** |
| Encargo del almacén | No | **Sí** |
| Fabricación propia | Sí | No |
| Pedido de embalaje | Sí | No |
| Permiso | Sí | No |
| Calculación interna | Sí | No |
| Pedido interno | Sí | No |
| Pago anticipado | Sí | No |
| Demanda | Sí | No |
| Material del cliente | Sí | No |

- La columna **Clave externa** está vacía en todos: no se ve integración con otros sistemas por esa vía.
- **Para el MCP:** esta lista corresponde a una tabla de tipos de documento. Conviene filtrar por los
  5 activos y confirmar después si hay documentos antiguos con tipos ya bloqueados.

## Preguntas resueltas con los manuales
- ✅ **GN pedido** = *Gestión de Números* de pedidos: un grupo de pedidos para aplicarles acciones en bloque.
- ✅ **Motor de base de datos:** SQL Server, esquema `SYSADM`.
- ✅ **Encargo del almacén** = orden de compra automática según los mínimos de stock.
- ✅ **Expedición parcial:** entregar una parte de un pedido. Se habilita en la ficha del cliente, pestaña 2.

## Preguntas abiertas
- ¿Qué es **Factura TPS**? Ningún manual lo menciona; podría ser un formulario propio de Trento.
- ✅ **Esquema de estatus:** tipo B, personalizado (430, 460, 485, 540, 990…). Falta la lista completa,
  que está en Datos básicos → Documentos → Gestión de estatus.
- ¿Trento usa **Tango** u otra contabilidad?
- ¿Tienen el **Gerente de producción**, ALCIM, XOPTON o Barcoding?
- ¿Usan la **gestión de caballetes** y la lista de acuse de recibo?
- ¿Qué módulos esconden los íconos pequeños de la barra inferior?
