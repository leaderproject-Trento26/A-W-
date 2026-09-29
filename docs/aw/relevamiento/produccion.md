# Relevamiento: Producción / Planta

> Estado: 🟡 **Respuestas previas desde la documentación** · Falta la entrevista para validar · Orden: **2.º área**
> Para la entrevista usa las secciones 1 a 7 de la [PLANTILLA](PLANTILLA.md).
> **Leyenda:** 📘 manual (así lo prevé A+W) · 📸 visto en Trento · ❓ a validar · 💡 conclusión.

## Lo que ya sabemos
- 📸 Trento tiene **BDE**: escaneo por código de barras en planta.
- 📸 Estatus vistos: 430 lote organizado · 460 BDE cortado · 485 BDE templado · 540 listo para envío.
- 📸 El tipo de documento **Pedido de producción** está activo.
- 📸 Existe una **lista de inventario de láminas** en A+W: el catálogo de láminas del prototipo se armó desde ella.

## Lo que A+W ofrece para Producción
| Funcionalidad | Dónde está | ¿Trento la usa? |
|---|---|---|
| Transmisión a producción (Carga GN / Cargar pedido) | Producción | ❓ Muy probable |
| **Gerente de producción**: tareas, optimización de corte y planos | Producción (AWB Pro) | ❓ |
| Lotes (organizado, liberado…) | Producción / ALCIM | ✅ 📸 (430) |
| **BDE**: escaneo por máquina | Terminales en planta | ✅ 📸 (460, 485) |
| Etiquetas de corte, de laminado y de DVH | Salida del Gerente de producción | ❓ |
| Lista de ocupación de caballetes | Salida del Gerente de producción | ❓ |
| Hojas enteras y stock de láminas | Almacén → Medidas H.E. / Gestión almacén | ✅ 📸 (hay lista de inventario) |
| Info Pedidos, pestaña "Producido" | Estadísticas | ❓ |

---

## Preguntas con respuesta previa

### 1. ¿Cómo llegan los pedidos a planta?
- 📘 **Manual:** hay que **transmitir a producción** el pedido. Hay cuatro formas:
  - **"Carga GN"**: se transmite toda una Gestión de Números. Es la forma recomendada.
  - "Cargar pedido": un solo pedido, útil para retransmitir tras una corrección.
  - El ícono **Entrega** en la cabecera del pedido.
  - Una **tarea de WorkFlow**, que transmite automáticamente los pedidos en cierto estatus.
- 📘 Al transmitir se **asignan las máquinas**. En el esquema de Trento aparecen 390 "Liberado para
  producción" y 450 "Lote liberado".
- 📘 Se puede **bloquear el pedido** para Ventas a partir de un estatus, para que no lo modifiquen una vez en planta.
- ❓ **Validar:**
  - ¿Quién transmite y cuándo (una vez al día, por turno)?
  - ¿Con Carga GN o de a uno?
  - ¿Los pedidos quedan bloqueados para Ventas?

### 2. ¿Quién arma los lotes y optimiza el corte?
- 📘 **Manual:** hay dos opciones en A+W:
  - **Gerente de producción (AWB Pro).** Se crea una **tarea** con los pedidos, se optimiza eligiendo
    medidas de hoja (o se marca "corte manual") y se generan los **códigos de corte** para la mesa.
  - **ALCIM / XOPTON.** Son módulos de planificación y optimización más avanzados.
- 💡 **Pista:** el texto "**LOTE ORGANIZADO**" del estatus 430 es terminología de **ALCIM**: en otra
  implementación existía "ALCIM – Lote organizado". Es posible que Trento use ALCIM.
- ❓ **Validar:**
  - ¿Con qué software optimizan el corte?
  - ¿La mesa de corte recibe el archivo desde A+W?

### 3. ¿En qué puestos se escanea?
- 📘 **Manual:** con Barcoding/BDE se pueden registrar cortado, **pulido**, **perforado** y templado.
- 📸 **Visto:** en Trento aparecen **cortado (460)** y **templado (485)**.
- 💡 No vimos estatus de pulido, perforado, laminado ni DVH. Puede que esos puestos **no escaneen**.
- ❓ **Validar:**
  - ¿Qué puestos escanean y cuáles no?
  - ¿Hay puestos donde se "olvida" escanear?

### 4. ¿Qué pasa con una rotura o una pieza rehecha?
- 📘 **Manual:** los manuales **no cubren** roturas ni reposiciones.
- ❓ **Validar:**
  - ¿Cómo se registra una rotura?
  - ¿Se crea un pedido nuevo?
  - ¿Se mide cuántas roturas hay?

### 5. ¿Cómo sabe la planta qué es urgente?
- 📘 **Manual:**
  - Cada pedido tiene su **fecha de entrega** en la cabecera.
  - En la Carga GN, A+W **obliga a cambiar la fecha** si es igual o anterior a hoy.
  - Las **rutas** definen el **turno** de salida. Si la ruta sale en el primer turno, el pedido debe
    estar terminado **el día anterior**.
- ❓ **Validar:**
  - ¿Usan la fecha de entrega para priorizar, o les avisan a mano?
  - ¿Hay pedidos "urgentes" marcados de alguna forma?

### 6. ¿Cómo se entera Logística de que un pedido terminó?
- 📘 **Manual:** con el estatus **540 "Fin de producción / Listo para envío"**, que cambia por la lectura
  de retorno de producción (BDE) o a mano.
- ❓ **Validar:**
  - ¿El 540 lo pone el último escaneo o una persona?
  - ¿Hay control de calidad antes? En otra implementación existía un estatus "Control de calidad".

### 7. ¿Usan el stock de láminas de A+W? ¿Coincide con la realidad?
- 📘 **Manual:**
  - El vidrio se controla por **hoja entera**, con medidas definidas en "Medidas H.E.".
  - El sistema calcula compras automáticas (**Encargo almacén**, tipo de documento activo en Trento 📸)
    con esta fórmula: mínimo − (stock − reservado + encargado).
  - Solo con XOPTON y retorno de hojas cortadas el stock se descuenta automáticamente. Si no, el stock
    **se corrige con inventarios**.
- 📸 **Visto:** existe la lista de inventario de láminas.
- ❓ **Validar:**
  - ¿El stock de A+W es confiable?
  - ¿Cada cuánto hacen inventario?
  - ¿Usan la compra automática?

### 8. ¿Qué indicadores miran?
- 📘 **Manual:**
  - **Info Pedidos**, pestaña "Producido": piezas, m² e importes por fecha de producción o lote, agrupados
    por familia o departamento.
  - Listados de **Crystal Reports**.
  - El Gerente de producción muestra el resultado de la optimización (aprovechamiento).
- ❓ **Validar:**
  - ¿Miran m² por día, roturas, atrasos o aprovechamiento de hojas?
  - ¿De dónde sacan esos números?

---

## Capturas a pedir
- La pantalla de lotes o del Gerente de producción.
- Una etiqueta de producción, anonimizada.
- La pantalla de escaneo BDE, si es posible.

## Resultado de la entrevista
_(pegar aquí)_

## 🤖 Análisis
_(lo completa Claude)_
