# Contexto del proyecto (memoria para Claude)

## Qué es este repo
- `prototipo/`: prototipo HTML de **Trento Entregas** (app de entregas, encuesta de calidad, catálogo de láminas).
- `docs/aw/`: revisión del ERP **A+W** que usa Trento (industria del vidrio).

## A+W en Trento (lo que sabemos)
- ERP **A+W Business** (antes **ALFAK**, de Albat + Wirsam). Versión pendiente de confirmar.
- **Base de datos: SQL Server, esquema `SYSADM`**, tablas en alemán por módulo:
  - `KU_KUNDEN` clientes, `LI_LIEFERANTEN` proveedores.
  - `BA_PRODUKTE` productos, `BA_LAGMA` hojas enteras.
  - `BW_AUFTR_KOPF/POS/STKL/HIST` pedidos.
  - `PR_*` precios, `RB_*` descuentos, `KA_*` tablas de apoyo.
  Detalle en `docs/aw/MODELO-DATOS.md`.
- **Base de datos de Trento: `TRENTO_BA`** (empresa `TRENTO`).
- Los documentos se controlan por **estatus numéricos**. Trento usa numeración de tipo B (cientos) con
  estatus de planta BDE: 430 lote organizado, 460 cortado, 485 templado, **540 listo para envío**, 990 cancelación.
- Se recibieron 30 manuales, resumidos en `docs/aw/MANUALES.md`. Los originales no están en el repo.
  *Gestión de Documentos* (2019) parece escrito para Trento: tiene estatus de Tango y su 540 coincide con el real.
- Las fichas de relevamiento ya traen **respuestas previas** sacadas de los manuales. Usan la leyenda
  📘 manual / 📸 visto / ❓ a validar. La entrevista sirve para validarlas, no para preguntar de cero.
- Menú lateral: **Datos básicos**, **Documentos**, **Producción** (hay más íconos ocultos).
- Carpetas de Datos básicos: General, Productos, Precios, Almacén, Partner del mercado, Expedición,
  Producción, Documentos, Finanzas, Empresa, Textos, Formularios, CEKAL, Distintivo CE, B2B.
- Pestañas en uso: Pedido, Factura TPS, Compra, GN pedido, Crystal Reports, Datos documentos, Tipos documento.
- Tipos de documento **activos** (no bloqueados): Reclamación, Expedición parcial, Pedido de producción,
  Pedido de contrato, Encargo del almacén. Los otros 10 están bloqueados.
- Propuestas de mejora en `docs/aw/propuestas/` (ej.: ciclo de vida de presupuestos en Ventas).
- Detalle y avance: `docs/aw/PLAN-REVISION.md` (hoja de ruta), `docs/aw/HALLAZGOS.md` y
  `docs/aw/relevamiento/` (una ficha por área).

## Decisión importante: MCP futuro
El usuario **desarrollará más adelante un servidor MCP para conectar Claude a la base de datos de A+W**.
Todo lo que se revise ahora (exports, capturas, diccionario de datos) debe servir de insumo para ese MCP:
- Anotar siempre qué pantalla, qué campos y con qué nombre aparecen, para mapearlos luego a tablas y columnas.
- El MCP debe ser de **solo lectura**, usar un usuario de BD dedicado y correr en la red de Trento
  (las sesiones en la nube no alcanzan la red interna).
- Motor de BD: Microsoft SQL Server (confirmado por el manual *Modelo de datos*), esquema `SYSADM`.
- No exponer al principio las tablas de precios y descuentos (`PR_*`, `RB_*`), porque son sensibles.
- Los documentos viejos se mueven cada año a una **base de datos de archivo** aparte.
- Requisitos y preguntas: `docs/aw/PLAN-REVISION.md` (Fase 6).

## Objetivo y contexto de la usuaria
- **Lidera la mejora** de operación y adopción de A+W en Trento.
- El orden acordado es: 1) entender el sistema con ayuda de Claude, 2) relevar cada área con
  `docs/aw/relevamiento/PLANTILLA.md`, 3) proponer mejoras, 4) conectar (base de datos y luego MCP).
  La hoja de ruta está en `docs/aw/PLAN-REVISION.md`.
- **Áreas en A+W:** Ventas, Producción y Logística.
- **Administración trabaja en Tango**, fuera de A+W. Se releva como 4.ª área, centrada en la **integración
  A+W ↔ Tango**: `docs/aw/relevamiento/administracion-tango.md`.
  - Lo que se sabe: estatus 235/240 "Transmitir/Importado a Tango" antes de producción, y 800 contabilidad.
  - Hay sesiones de pagos (Import./export. Pagos, Recibos bancarios, Pagos a cuenta) y "Factura TPS".
  - La usuaria dará más contexto de Tango; guardarlo en esa ficha.
- Hojas imprimibles de las 4 áreas: `docs/aw/relevamiento/imprimir/`. La usuaria trabaja en papel cuando
  no tiene la computadora.
- **Etapa actual: pre-relevamiento.** La usuaria envía **minutas de reuniones** previas con las áreas,
  antes de hacer las entrevistas formales.
  - Cada minuta se guarda en `docs/aw/relevamiento/minutas/`, anonimizada.
  - Lo que aporta se vuelca en la ficha del área con la marca 🗣️ (minuta).
  - Las preguntas de la entrevista se ajustan: se sacan las ya respondidas y se agregan las nuevas dudas.
- Tiene permiso para **leer la base de datos**, pero todavía no se conectó. Lo validamos cuando lleguemos a esa etapa.
- Forma de conexión: **Claude le indica en cada momento qué hace falta** (captura, export, Computer use o
  Claude Code local).

## Forma de trabajo con el usuario
- Responder en español, paso a paso y sin suponer que conoce A+W.
- No subir datos sensibles (precios reales, datos personales de clientes) sin anonimizar.
