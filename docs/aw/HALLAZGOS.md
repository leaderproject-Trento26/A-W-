# Hallazgos de la revisión de A+W

Registro de todo lo que vamos descubriendo. Cada hallazgo indica su **fuente** (captura o export en `docs/aw/`).

## Sistema
- **Producto:** A+W, probablemente **A+W Business** (ERP para vidrio). Versión: _pendiente (Fase 1.1)_.
- **Conexión mostrada:** `A+W`.

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

## Preguntas abiertas
- ¿Qué es **GN pedido**?
- ¿Qué es **Factura TPS**?
- ¿Qué módulos esconden los íconos pequeños de la barra inferior?
- ¿Qué motor de base de datos usa A+W en Trento?
