# Relevamiento: Ventas / Comercial

> Estado: 🟡 **Respuestas previas desde la documentación** · Falta la entrevista para validar · Orden: **3.º área**
> Para la entrevista usa las secciones 1 a 7 de la [PLANTILLA](PLANTILLA.md).
> **Leyenda:** 📘 manual (así lo prevé A+W) · 📸 visto en Trento · ❓ a validar · 💡 conclusión.

## Lo que ya sabemos
- 📸 Unos **300 pedidos por mes** (la GN de septiembre tiene 309). Los pedidos se numeran con 8 dígitos (ej. 12006783).
- 📸 Tipos de documento activos: Reclamación, Pedido de contrato y Expedición parcial.
- 📸 El menú Pedido incluye: Introd. pedidos, **Control de ofertas**, **Gestión de obras**, Consulta rápida,
  **Importación**, Transmisión contabilidad, Import./export. Pagos, Recibos bancarios, **Factura TPS** y
  Comprobantes de garantía.
- 📸 En Datos básicos existe una carpeta **B2B**.

## Lo que A+W ofrece para Ventas
| Funcionalidad | Dónde está | ¿Trento la usa? |
|---|---|---|
| Ofertas con seguimiento | Documentos → Oferta / Control de ofertas | ❓ El menú existe 📸 |
| Copiar una oferta a pedido | Funciones → Copiar documentos | ❓ |
| Introducción de pedidos | Documentos → Pedido → Introd. pedidos | ✅ 📸 |
| **Macros**: composiciones guardadas | Pedido → Estructura → Salvar como macro | ❓ |
| **Alternativas**: cambiar composición en bloque | Funciones → Alternativas | ❓ |
| **Excel Line Import**: pegar medidas desde Excel | Pedido → Importación de portapapeles | ❓ (requiere licencia) |
| **Obras**: precios pactados por obra | Gestión de obras | ❓ El menú existe 📸 |
| **Reclamaciones** | Tipo de documento Reclamación | ✅ 📸 El tipo está activo |
| Límite de crédito | Ficha de cliente, pestaña 7 | ❓ (depende de Tango) |
| Info Pedidos y Estadística de ventas | Estadísticas | ❓ |

---

## Preguntas con respuesta previa

### 1. ¿Cómo llega un pedido?
- 📘 **Manual:** A+W no registra el canal (mail, WhatsApp, visita). Ofrece dos cosas:
  - Carga manual en *Introd. pedidos*: cabecera (cliente, fecha de entrega, referencia), luego posiciones
    y lista de piezas.
  - **Excel Line Import**: pegar desde Excel las piezas, ancho, alto y referencia. Requiere la licencia
    del módulo y A+W 6.4 o superior.
- 📘 La carpeta **B2B** sugiere un posible canal de pedidos online de clientes.
- ❓ **Validar:**
  - ¿Por qué canal llegan los pedidos?
  - ¿Alguno entra por B2B?

### 2. ¿Hacen oferta antes del pedido? ¿Registran si se aceptó?
- 📘 **Manual:**
  - La oferta es un documento propio. Se **copia a pedido** con Funciones → Copiar documentos.
  - En otra implementación se usaban estatus de oferta **rechazada (23)**, con motivo obligatorio,
    **aceptada (25)** y **copiada a pedido (27)**.
  - Así se puede medir la **tasa de conversión** y los motivos de rechazo.
- 📸 **Visto:** existe **Control de ofertas** en el menú.
- ❓ **Validar:**
  - ¿Cargan ofertas en A+W o las hacen en Excel?
  - ¿Registran aceptación o rechazo, y el motivo?

### 3. ¿Cuánto tarda cargar un pedido? ¿Qué es lo más lento?
- 📘 **Manual:** A+W tiene herramientas para acelerar la carga:
  - **Parrilla configurable** por usuario, con piezas, ancho y alto a la izquierda.
  - Atajos **F9** (formas y procesos) y **F10** (barrotillos).
  - **Macros**: guardar una composición frecuente con nombre, por cliente o general.
  - **Alternativas**: cambiar, por ejemplo, un laminado 3+3 por 4+4 en todas las posiciones de una vez,
    y recalcular el precio.
  - **Excel Line Import**.
- ❓ **Validar:**
  - ¿Conocen y usan estas herramientas?
  - ¿Cuánto tarda un pedido típico?

  💡 Si no las usan, **la capacitación es una mejora rápida y barata**.

### 4. ¿Cargan medidas a mano cuando el cliente manda un Excel?
- 📘 **Manual:** el **Excel Line Import** resuelve justamente eso: se copia la planilla y se pega en el pedido.
- 📸 **Visto:** hay una opción **"Importación"** en el menú Pedido. Falta saber si es este módulo.
- ❓ **Validar:**
  - ¿Tienen la licencia?
  - ¿Qué hace la opción "Importación"?

### 5. ¿Cómo informan la fecha de entrega y el estado del pedido?
- 📘 **Manual:**
  - La **fecha de entrega** está en la cabecera del pedido.
  - A+W avisa si no coincide con los días de la **ruta** del cliente.
  - El estado se ve por el **estatus**: 430 lote, 460 cortado, 485 templado, 540 listo, 600 remito.
  - Hay sesiones de consulta: **Consulta rápida** 📸, Búsqueda y GN.
- 💡 Con el estatus BDE, Ventas podría decirle al cliente "su pedido ya está cortado y en templado"
  **sin llamar a planta**.
- ❓ **Validar:**
  - ¿Ventas mira el estatus, o llama o pregunta a planta?
  - ¿Los clientes preguntan mucho por el estado de su pedido?

### 6. ¿Cómo se registra y sigue una reclamación?
- 📘 **Manual:**
  - "Reclamaciones" aparece como ejercicio en la capacitación de A+W Business, pero **no hay un manual detallado**.
  - Es un **subtipo de pedido**, así que sigue el mismo flujo de estatus.
- 📸 **Visto:** el tipo **Reclamación** está activo.
- ❓ **Validar:**
  - ¿Quién la crea?
  - ¿Genera reposición en planta?
  - ¿Se registra el motivo?
  - ¿Se mide cuántas hay?

### 7. ¿Qué pasa de A+W a Tango?
- 📘 **Manual (escrito para Trento):**
  - Hay estatus **235 "Transmitir a Tango"** y **240 "Importado a Tango"**, antes de producción.
    Probablemente se da de alta el pedido o el cliente en Tango.
  - Más adelante: 750 **factura impresa** → 800 **transmisión a contabilidad** → 850 estadísticas → 900 archivo.
- 📸 **Visto:** en el menú existen Transmisión contabilidad, **Import./export. Pagos**, **Recibos bancarios**,
  Administración de pagos a cuenta y **Factura TPS**.
- 📘 El **límite de crédito** de A+W depende de que la contabilidad devuelva los **saldos**. Si Tango no
  los devuelve, el control de crédito no funciona.
- ❓ **Validar:**
  - ¿Se factura en A+W o en Tango?
  - ¿Qué es "Factura TPS"?
  - ¿Los pagos vuelven de Tango a A+W?
  - Esto conecta con el contexto de Tango que vas a pasar.

### 8. ¿Qué informes o números miran?
- 📘 **Manual:** hay tres fuentes.
  - **Info Pedidos:** no requiere facturar. Pestañas Introducido, Producido, Facturado y Abierto.
    La pestaña **Introducido** sirve para seguir la **entrada diaria de pedidos**.
  - **Estadística de ventas:** solo por mes o año. Requiere transmitir los pedidos a estadística.
  - **Crystal Reports**, que está abierto como pestaña 📸.
- 📘 **Cuidado al contar piezas:** un DVH cuenta 1 pieza en la posición, pero 4 si se incluye la lista de piezas.
- ❓ **Validar:**
  - ¿Qué números miran y con qué frecuencia?
  - ¿Los sacan de A+W, de Tango o de Excel?

---

## Capturas a pedir
- La pantalla de introducción de pedido (posiciones), anonimizada.
- Control de ofertas.
- Una reclamación, si hay.
- La pantalla de la opción "Importación" y de "Factura TPS".

## Resultado de la entrevista
_(pegar aquí)_

## 🤖 Análisis
_(lo completa Claude)_
