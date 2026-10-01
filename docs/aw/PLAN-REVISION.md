# Plan de trabajo: A+W en Trento

## Para qué hacemos esto
1. **Entender** cómo funciona A+W en Trento, con Claude como guía.
2. **Relevar cada área:** qué usa del sistema, qué hace por fuera (Excel, papel, WhatsApp) y dónde se traba.
3. **Mejorar** la operación y la adopción del sistema.
4. Recién entonces, **conectar** Claude a los datos: primero con lectura de la base y después con el MCP.

**Quién lidera:** la usuaria, que conduce el relevamiento y la mejora.

**Áreas:**
- En A+W: **Ventas, Producción y Logística**.
- Fuera de A+W: **Administración**, que trabaja en **Tango**. El contexto de Tango queda pendiente de recibir.

## Mi opinión sobre el camino
Primero entender y después conectar es el orden correcto: el relevamiento dice **qué datos importan**, y el
MCP se diseña para responder esas preguntas, no para exponer toda la base.

Aun así, conviene hacer **una prueba de conexión a la base temprano**, en la etapa 2. No es para construir
nada: sirve para confirmar que el acceso funciona y ver las tablas reales. Así cada pantalla que relevemos
se puede asociar a su tabla, y el MCP sale casi solo.

---

## Hoja de ruta

| Etapa | Qué hacemos | Resultado | Estado |
|---|---|---|---|
| **0. Base de conocimiento** | Leer los manuales y las capturas iniciales | `MANUALES.md`, `MODELO-DATOS.md`, `HALLAZGOS.md` | ✅ Hecho |
| **1. Relevamiento por área** | Aplicar la plantilla en Ventas, Producción y Logística | Una ficha por área en `relevamiento/` | ▶️ Siguiente |
| **2. Prueba de conexión (solo lectura)** | Conectarse a `TRENTO_BA` y listar tablas | Confirmar el acceso y la lista real de tablas | ⚪ |
| **3. Diagnóstico y mejoras** | Cruzar las fichas: brechas, retrabajos, datos que faltan | Informe de hallazgos y plan de mejoras priorizado | ⚪ |
| **4. Integración con Tango** | Relevar Administración con la ficha `relevamiento/administracion-tango.md`: qué pasa entre A+W y Tango | Mapa del flujo A+W ↔ Tango | 🟡 Ficha y hoja lista; falta entrevista y contexto de Tango |
| **5. MCP de solo lectura** | Construir el MCP con las preguntas que salieron del relevamiento | MCP funcionando en la red de Trento | ⚪ |
| **6. Trento Entregas con datos reales** | Conectar el prototipo a los pedidos 540 (listos para envío) | App con datos reales | ⚪ (opcional) |

---

## Etapa 1: Relevamiento por área (lo que sigue)

**Orden sugerido:**
1. **Logística:** es la más ligada a Trento Entregas y la que más conocemos.
2. **Producción**
3. **Ventas**

**Cómo relevar un área** (1 o 2 sesiones por área):
1. **Antes, con Claude (15 minutos).** Abres la ficha del área en `relevamiento/`, que ya trae
   precargado **lo que A+W ofrece** para esa área según los manuales. Repasamos juntas qué preguntar.
2. **Con el área (30 a 60 minutos).** Te sientas con quien hace el trabajo y completas la ficha: qué hace,
   en qué pantallas, qué hace por fuera del sistema y qué le molesta. Si puedes, **graba el audio** o toma
   notas, y saca **capturas** de las pantallas que usan.
3. **Después, con Claude.** Me pasas las notas y capturas. Yo completo la ficha, marco las **brechas**
   (lo que A+W permite pero no se usa) y propongo mejoras.

**La plantilla:** [`relevamiento/PLANTILLA.md`](relevamiento/PLANTILLA.md).

## Etapa 2: Prueba de conexión
Cuando lleguemos a esta etapa, validamos juntas cómo conectarte. Lo más probable es usar
**SQL Server Management Studio** con tu usuario de solo lectura.
La primera consulta **solo lista tablas**, no lee datos (ver `MODELO-DATOS.md`).

## Cómo nos conectamos en cada sesión
Tú prefieres que yo te diga en cada caso qué hace falta. Esta es la regla:

| Si necesitamos… | Cómo |
|---|---|
| Ver una pantalla o un dato puntual | Me mandas una **captura** (`Win + Shift + S`) |
| Una lista larga (pedidos, clientes) | La **exportas a Excel** y me la pasas (**anonimizada**) |
| Recorrer muchas pantallas seguidas | Sesión nueva en la app de escritorio con **Computer use** |
| Consultar la base o construir el MCP | Sesión de **Claude Code local** en una PC de la red de Trento |

---

## Próximas sesiones (checklist)
- [ ] **Sesión 1:** repasar la ficha de **Logística** y preparar la entrevista.
- [ ] **Sesión 2:** entrevista con Logística y cargar los resultados.
- [ ] **Sesión 3:** ficha de **Producción** (preparar, entrevistar y cargar).
- [ ] **Sesión 4:** ficha de **Ventas** (preparar, entrevistar y cargar).
- [ ] **Sesión 5:** prueba de conexión a `TRENTO_BA` (listar tablas).
- [ ] **Sesión 6:** diagnóstico cruzado y plan de mejoras.
- [ ] **Sesión extra:** entrevista con **Administración**, sobre la integración A+W ↔ Tango.
  Hoja: `relevamiento/imprimir/entrevista-administracion-tango.pdf`.
- [ ] Cuando esté disponible: contexto de **Tango** (versión, módulos, quién lo administra).

Las **hojas para imprimir** de las 4 áreas están en `relevamiento/imprimir/`. Si un área no está disponible,
se pasa a la siguiente.

## Pendientes sueltos (se resuelven durante el relevamiento)
- Lista completa de estatus de Trento: **Datos básicos → Documentos → Gestión de estatus**.
- Versión de A+W: **Ayuda → Acerca de**.
- Qué es "**Factura TPS**".
- Documentación oficial de tablas: **Inicio → Programas → Albat + Wirsam → Documentation**.
