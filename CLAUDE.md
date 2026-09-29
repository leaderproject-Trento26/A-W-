# Contexto del proyecto (memoria para Claude)

## Qué es este repo
- `prototipo/`: prototipo HTML de **Trento Entregas** (app de entregas, encuesta de calidad, catálogo de láminas).
- `docs/aw/`: revisión del ERP **A+W** que usa Trento (industria del vidrio).

## A+W en Trento (lo que sabemos)
- ERP A+W, muy probablemente **A+W Business**; la versión está pendiente de confirmar en Ayuda → Acerca de.
- Menú lateral: **Datos básicos**, **Documentos**, **Producción** (hay más íconos ocultos).
- Carpetas de Datos básicos: General, Productos, Precios, Almacén, Partner del mercado, Expedición,
  Producción, Documentos, Finanzas, Empresa, Textos, Formularios, CEKAL, Distintivo CE, B2B.
- Pestañas en uso: Pedido, Factura TPS, Compra, GN pedido, Crystal Reports, Datos documentos, Tipos documento.
- Tipos de documento **activos** (no bloqueados): Reclamación, Expedición parcial, Pedido de producción,
  Pedido de contrato, Encargo del almacén. Los otros 10 están bloqueados.
- Detalle y avance: `docs/aw/PLAN-REVISION.md` y `docs/aw/HALLAZGOS.md`.

## Decisión importante: MCP futuro
El usuario **desarrollará más adelante un servidor MCP para conectar Claude a la base de datos de A+W**.
Todo lo que se revise ahora (exports, capturas, diccionario de datos) debe servir de insumo para ese MCP:
- Anotar siempre qué pantalla, qué campos y con qué nombre aparecen, para mapearlos luego a tablas y columnas.
- El MCP debe ser de **solo lectura**, usar un usuario de BD dedicado y correr en la red de Trento
  (las sesiones en la nube no alcanzan la red interna).
- Motor de BD: probablemente Microsoft SQL Server, pendiente de confirmar con sistemas.
- Requisitos y preguntas: `docs/aw/PLAN-REVISION.md` (Fase 6).

## Forma de trabajo con el usuario
- Responder en español, paso a paso y sin suponer que conoce A+W.
- No subir datos sensibles (precios reales, datos personales de clientes) sin anonimizar.
