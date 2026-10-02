# Propuesta: ciclo de vida de presupuestos en A+W

> Origen: [minuta Ventas 1](../relevamiento/minutas/2026-10-ventas-01.md). Estado: **borrador para validar**.
> **Leyenda:** 📘 manual · 📸 visto en Trento · 🗣️ minuta · ❓ a validar.

## La pregunta
¿A+W permite seguir cada presupuesto (en revisión, presentado, aceptado, rechazado, vencido), o hay que
armar algo aparte que se integre con A+W?

## Respuesta corta
**A+W no es un CRM, pero sí puede llevar el ciclo de vida del presupuesto.** No hace falta un sistema aparte
para registrar los estados. Lo que A+W **no** tiene es la **vista**: un tablero con el embudo, los tiempos
y los indicadores. Eso sí conviene construirlo, leyendo los datos de A+W.

| Necesidad | ¿A+W lo resuelve? | Cómo |
|---|---|---|
| Registrar el presupuesto | ✅ | Documento **Oferta** (tablas `BW_ANGEB_*`) |
| Estados del presupuesto | ✅ Configurable | Estatus propios de la oferta. A+W permite **crear estatus y modificar el flujo** 📘 |
| Fecha y usuario de cada cambio de estado | ✅ | **Historia del documento** (`BW_ANGEB_HIST`) 📘 |
| Motivo de rechazo obligatorio | ✅ | Campo **Categoría** obligatorio al rechazar. Ya se hizo en otra implementación 📘 |
| Convertir el presupuesto aceptado en pedido | ✅ | Copiar oferta a pedido. Queda trazado el estatus "copiada a pedido" 📘 |
| Que solo el Gerente apruebe descuentos mayores al 20 % | 🟡 Parcial | Permisos por grupo sobre precios, descuentos y cambios de estatus 📘. El umbral del 20 % no es automático; se resuelve con un estatus "pendiente de autorización" que solo el Gerente puede mover |
| Estado "Vencido" automático | 🟡 Parcial | Con una **tarea de WorkFlow** que cambie el estatus pasado X días 📘, o marcándolo a mano. ❓ Confirmar si la licencia incluye WorkFlow |
| Controlar el tiempo de respuesta de 24 a 48 h | 🟡 | El dato está (fecha de creación y fecha de "presentado" en la historia), pero A+W no alerta |
| Canal de captación (llamada, visita, web) | 🟡 | Con **clasificadores**: campos personalizados en la ficha de cliente 📘, o con la categoría de la oferta |
| Clientes activos e inactivos | 🟡 | Se calcula: fecha del último pedido por cliente, más el código de bloqueo |
| **Tablero de embudo, conversión, tiempos y proyección** | ❌ | **Hay que construirlo** leyendo A+W (tablero conectado a la base de datos) |
| Seguimiento comercial previo al presupuesto (llamadas, recordatorios) | ❌ | A+W no lo tiene. Evaluar si hace falta, o si alcanza con los estados |

📸 En el menú de Trento ya existe **"Control de ofertas"**: hay que ver qué muestra hoy.

## Responsables (matriz)
Cada punto tiene tres tipos de responsabilidad:
- **Opera:** lo hace en el día a día.
- **Define o aprueba:** decide las reglas.
- **Configura:** lo deja funcionando en A+W.

| # | Qué | A+W | Opera (día a día) | Define / aprueba | Configura en A+W | Seguimiento |
|---|---|---|---|---|---|---|
| 1 | Registrar todo presupuesto como **Oferta** | ✅ | **Vendedores** ❓ quiénes | **Otto** (Jefe de Ventas): regla "todo presupuesto va a A+W" | No requiere | **Milena** (adopción) |
| 2 | Estados: en revisión, presentado, aceptado, rechazado, vencido | ✅ | Vendedores | **Sebastián + Otto** acuerdan los estados | **Administrador de A+W** ❓ | Milena |
| 3 | Ver cuándo y quién cambió cada estado (historia) | ✅ | Consultan **Otto** y **Sebastián** | No aplica | No requiere | Milena verifica que se registre |
| 4 | Motivo obligatorio al rechazar | ✅ | Vendedores | **Otto** define la lista de motivos | Administrador de A+W ❓ | Milena |
| 5 | Descuentos mayores al 20 % solo con autorización | 🟡 | El vendedor pasa la oferta a "pendiente de autorización" | **Sebastián** (Gerente de Ventas) aprueba | Administrador de A+W ❓ (estatus y permisos) | Milena |
| 6 | Marcar "Vencido" automáticamente | 🟡 | Automático, o el vendedor | **Otto** define los días de validez | Administrador de A+W ❓. **Verificar con el proveedor** si la licencia incluye WorkFlow | Milena |
| 7 | Canal de contacto (llamada, visita, web…) | 🟡 | Vendedores, al dar de alta al cliente | **Sebastián** define la lista de canales | Administrador de A+W ❓ (clasificador) | Milena |
| 8 | Lista de precios actualizada cada 3 meses | ✅ | **Luciana** carga | **Sebastián** la recibe; **Otto** la revisa | No requiere | Milena mide la demora |
| 9 | **Tablero comercial** (embudo, conversión, tiempos, proyección) | ❌ A construir | Lo usa **Sebastián** | **Sebastián + Otto** definen los indicadores | **Milena + Claude** lo construyen con lectura de la base | Milena |

**Roles por confirmar:**
- **Vendedores:** ¿quiénes cargan los presupuestos?
- **Administrador de A+W:** ¿quién puede configurar estatus, permisos y WorkFlow? ¿Alguien de Trento, o el proveedor de A+W?

## Estados propuestos (a configurar en A+W)
Se mapean los estados que pidió Ventas a estatus de la oferta. **Los números son un ejemplo**: se definen con
quien administre A+W, respetando los que ya existan.

| Estado de negocio 🗣️ | Estatus de A+W (ejemplo) | Quién lo cambia | Cómo |
|---|---|---|---|
| Presupuesto (solicitado) | 1 Documento creado | Vendedor | Automático al crear |
| En revisión | 10 En revisión | Vendedor | Botón Estatus |
| Pendiente de autorización (descuento > 20 %) | 15 Pend. autorización | Vendedor | Botón Estatus. **Solo el Gerente puede sacarlo de aquí** |
| Presentado | 200 Oferta editada / enviada | Automático | **Al imprimir o enviar la oferta** 📘 |
| Aceptado | 25 Aceptada | Vendedor | Botón Estatus. Después se copia a pedido |
| Rechazado | 23 Rechazada + **motivo obligatorio** | Vendedor | Botón Estatus. La oferta queda bloqueada |
| Vencido | 30 Vencida | WorkFlow o vendedor | Pasados X días sin respuesta |
| Convertido en pedido | 27 Copiada a pedido | Automático | Al copiar a pedido |

**Reglas de precio** 🗣️ y dónde viven en A+W 📘:

| Regla | Dónde vive |
|---|---|
| Distribución, lista fija con aumento trimestral | **Tablas de precio** (`PR_PREIS`) |
| DVH, porcentaje por cliente | **Descuentos de cliente por familia** (`RB_KU_WGR`) |
| Vidrios especiales, del 5 % al 20 % | Descuento manual en la posición, limitado por permisos |
| Desperdicio y rentabilidad (lo que trabaja el Jefe de Ventas) | El módulo **Optimización de ofertas** (AWB Pro, licencia 151) 📘 optimiza el corte de un presupuesto y muestra el aprovechamiento de la hoja. ❓ Confirmar si Trento lo tiene |

## Qué construir afuera: el tablero comercial
Cuando haya conexión de lectura a la base, el tablero se arma **leyendo A+W, sin duplicar datos**:
- **Embudo:** cantidad y monto de presupuestos por estado.
- **Conversión:** % aceptados sobre presentados, por vendedor, cliente y tipo de vidrio.
- **Tiempo de respuesta:** creado → presentado, comparado con el objetivo de 24 a 48 h.
- **Motivos de rechazo**, y presupuestos vencidos sin seguimiento.
- **Descuentos:** promedio por tipo, cantidad por encima del 20 % y quién los autorizó.
- **Clientes** activos e inactivos, y canal de captación.
- **Proyección:** monto en curso × tasa de conversión histórica, igual a la venta esperada del mes.
  Es la base del plan de planificación y proyección para el Gerente.

## Pasos sugeridos
1. **Relevar el estado actual** (en la entrevista de Ventas):
   - ¿Hoy cargan los presupuestos como **Oferta** en A+W, o en Excel?
   - ¿Qué muestra **Control de ofertas**?
   - ¿Qué estatus de oferta están configurados? Ver *Datos básicos → Documentos → Gestión de estatus*.
2. **Acordar los estados** con el Gerente y el Jefe de Ventas (tabla de arriba).
3. **Configurar en A+W** con quien lo administre: estatus, permisos y WorkFlow de vencimiento.
4. **Usar 1 mes** y medir.
5. **Construir el tablero** con lectura de la base (`BW_ANGEB_KOPF` y `BW_ANGEB_HIST`).
6. **Plan de planificación y proyección** para el Gerente, con los datos del tablero.

## Riesgos a tener en cuenta
- Si los presupuestos **no se cargan en A+W**, nada de esto funciona. La adopción es el paso 1.
- Configurar estatus y permisos puede requerir al **proveedor de A+W**.
- La lista de precios pasa por **3 personas** antes de cargarse: hay riesgo de demoras y de presupuestos con
  precios viejos. ❓ ¿Cuánto tarda en cargarse cada aumento?
