# Relevamiento: Administración e integración A+W ↔ Tango

> Estado: 🟡 **Respuestas previas desde la documentación** · Falta la entrevista para validar · Área nueva (4.ª)
> Para la entrevista usa las secciones 1 a 7 de la [PLANTILLA](PLANTILLA.md).
> **Leyenda:** 📘 manual (así lo prevé A+W) · 📸 visto en Trento · ❓ a validar · 💡 conclusión.
> **Pendiente:** el contexto de Tango que va a pasar la usuaria (versión, módulos, quién lo administra).

## Por qué esta área es distinta
Administración **no trabaja en A+W sino en Tango**. Aquí no se releva solo el uso de un sistema:
se releva **la frontera entre los dos**. Lo que interesa es:
- Qué datos pasan de un sistema al otro, cuándo, cómo y quién lo hace.
- Qué se carga **dos veces**.
- Qué no coincide entre los dos sistemas, y cómo se detecta.

## Lo que ya sabemos
- 📘 El manual *Gestión de Documentos*, probablemente escrito para Trento, tiene estatus propios de Tango
  en el flujo del pedido:

  | Estatus | Significado | Momento |
  |---|---|---|
  | 200 | Confirmación de pedido impresa | Antes de Tango |
  | **235** | **Transmitir a Tango** | Antes de producción |
  | **240** | **Importado a Tango** | Antes de producción |
  | 390 | Liberado para producción | Después de Tango |
  | 600 | Albarán (remito) de entrega | |
  | 750 | Factura impresa | |
  | 800 | Transmisión a contabilidad | |
  | 850 / 900 | Estadísticas / Archivo | |

  💡 Que el paso a Tango ocurra **antes de liberar a producción** sugiere que Tango interviene en un control
  previo, por ejemplo el alta del cliente, una seña o la aprobación de crédito. Hay que validarlo.
- 📸 Sesiones del menú *Documentos → Pedido* relacionadas con Administración:
  - Transmisión contabilidad
  - **Import./export. Pagos**
  - Diario
  - **Administración de pagos a cuenta**
  - Pedidos pago anticip.
  - **Recibos bancarios**
  - **Factura TPS**
  - Comprobantes de garantía
  - Recalcular
  - Transmisión encargo
- 📸 El tipo de documento **"Pago anticipado" está BLOQUEADO**, pero existen las sesiones de pagos a cuenta y
  de pedidos con pago anticipado.
- 📸 Hay una pestaña **Compra** abierta: también hay circuito de compras.

## Lo que A+W ofrece para Administración
| Funcionalidad | Dónde está | ¿Trento la usa? |
|---|---|---|
| Transmisión a Tango (235 → 240) | Sesión de transmisión | ❓ El manual dice que sí |
| Facturación en A+W (750) | Edición pedido → modo factura | ❓ ¿O se factura en Tango? |
| Transmisión a contabilidad (800) | Documentos → Pedido → Transmisión contabilidad | ❓ La sesión existe 📸 |
| Importar y exportar pagos | Documentos → Pedido → Import./export. Pagos | ❓ La sesión existe 📸 |
| Pagos a cuenta / anticipos | Administración de pagos a cuenta / Pedidos pago anticip. | ❓ El tipo está bloqueado 📸 |
| Recibos bancarios | Documentos → Pedido → Recibos bancarios | ❓ La sesión existe 📸 |
| Límite de crédito con retorno de saldos | Ficha de cliente, pestaña 7 | ❓ |
| Datos financieros del cliente (CUIT, condición y forma de pago, bloqueo) | Ficha de cliente, pestaña 6 | ❓ |
| Divisas (pesos / dólares, tipo de cambio) | Datos básicos → Finanzas / ficha de cliente | ❓ |
| Compras: entrada de mercadería (259/260) y control de factura (265) | Documentos → Encargo | ❓ |
| Transmisión de compras (encargos) | Documentos → Pedido → Transmisión encargo | ❓ La sesión existe 📸 |

---

## Preguntas con respuesta previa

### 1. ¿Qué pasa de A+W a Tango, y cuándo?
- 📘 **Manual:**
  - Hay dos momentos de transmisión:
    1. **Antes de producción:** 235 "Transmitir a Tango" → 240 "Importado a Tango".
    2. **Después de facturar:** 800 "Transmisión a contabilidad".
  - En general, A+W genera un **fichero de traspaso** que el otro sistema importa.
- ❓ **Validar:**
  - ¿Qué viaja en cada momento: clientes, pedidos, facturas, cobros?
  - ¿Es automático o alguien lo ejecuta a mano? ¿Cada cuánto?
  - ¿Quién lo hace?

### 2. ¿Dónde se emite la factura?
- 📘 **Manual:**
  - A+W puede imprimir la factura (estatus 750). Para eso exige haber impreso antes el remito.
  - Después la transmite a contabilidad (800).
- 💡 En Argentina la factura debe ser **electrónica, con CAE** de ARCA. Suele resolverla el sistema
  contable o de gestión, en este caso posiblemente Tango.
- 📸 Existe una sesión "**Factura TPS**" en A+W.
- ❓ **Validar:**
  - ¿La factura legal sale de A+W o de Tango?
  - ¿Qué es "Factura TPS"?
  - ¿Se carga algo dos veces?

### 3. ¿Dónde se dan de alta los clientes?
- 📘 **Manual:** la ficha de cliente de A+W tiene datos financieros en la pestaña 6: CUIT, condición y forma de pago,
  **cuenta contable** y código de bloqueo.
  Las **filiales** (direcciones de entrega o facturación distintas) deben tener la **misma cuenta
  contable** que el cliente principal. Si no, el traspaso a contabilidad sale mal.
- ❓ **Validar:**
  - ¿El cliente se crea primero en A+W o en Tango?
  - ¿Los códigos coinciden?
  - ¿Hay clientes duplicados o con datos distintos en cada sistema?

### 4. ¿Cómo vuelven los cobros a A+W?
- 📸 **Visto:** existen las sesiones **Import./export. Pagos**, **Recibos bancarios** y **Administración de pagos a cuenta**.
- 📘 **Manual:** el control de crédito de A+W necesita un **fichero de "retorno de saldos"** que genera la
  contabilidad. A+W lo procesa con *Exchange Service* o con una personalización.
- ❓ **Validar:**
  - ¿Los cobros que registra Tango vuelven a A+W?
  - ¿Ventas puede ver si un cliente debe plata?

### 5. ¿Cómo manejan señas y anticipos?
- 📘 **Manual:** el módulo licenciado de **pagos anticipados** crea un pedido de anticipo (posición 999),
  lo factura y descuenta el importe en el pedido original.
  En otra implementación, los pedidos de contado esperaban en un estatus "**recibo de caja pendiente**"
  hasta que Caja registraba el pago.
- 📸 **Visto:** el tipo "Pago anticipado" está **bloqueado**, pero existen "Administración de pagos a cuenta"
  y "Pedidos pago anticip.".
- ❓ **Validar:**
  - ¿Piden seña antes de producir?
  - ¿Dónde se registra: A+W, Tango o ambos?
  - ¿Quién autoriza que un pedido pase a producción sin seña?

### 6. ¿Hay control de crédito o de deuda antes de producir?
- 📘 **Manual:**
  - A+W puede **bloquear pedidos nuevos**, o marcarlos con un estatus especial, si el cliente supera su límite.
  - Para eso necesita el **saldo** que devuelve la contabilidad.
  - El campo "Pedidos" del cliente suma los pedidos entre los estatus 1 y 800.
- ❓ **Validar:**
  - ¿Quién decide si un cliente deudor puede seguir comprando?
  - ¿Se controla en A+W, en Tango o a mano?

### 7. ¿Trabajan en pesos y dólares?
- 📘 **Manual:**
  - A+W guarda los valores en moneda nacional y en moneda extranjera.
  - El tipo de cambio puede quedar **fijado en el pedido** o tomarse **al facturar**.
- ❓ **Validar:**
  - ¿Hay listas de precio o clientes en dólares?
  - ¿Con qué tipo de cambio se factura?
  - ¿Tango y A+W usan el mismo tipo de cambio?

### 8. ¿Cómo funciona el circuito de compras?
- 📘 **Manual:**
  - En A+W la compra (Encargo) sigue este circuito: impresa (200) → **entrada parcial o completa de
    mercadería** (259 / 260) → **control de factura** (265) → contabilidad (800).
  - Existe también la **compra automática** de stock (Encargo almacén, activo en Trento 📸).
- ❓ **Validar:**
  - ¿Las compras se cargan en A+W, en Tango o en ambos?
  - ¿Dónde se controla la factura del proveedor?

### 9. ¿El remito sale de A+W o de Tango?
- 📘 **Manual:** A+W imprime el remito o guía (estatus 600) desde *Edición pedido* o desde *Expedición → Formularios*.
- ❓ **Validar:**
  - ¿El remito legal (con CAI o electrónico) sale de A+W o de Tango?
  - ¿Coincide con lo que lleva el chofer?

### 10. ¿Cómo verifican que A+W y Tango coinciden?
- 📘 **Manual:** no hay un proceso descrito de conciliación entre los dos sistemas.
- ❓ **Validar:**
  - ¿Qué pasa si un pedido se modifica después de pasar a Tango?
  - ¿Hay errores de transmisión? ¿Cómo se detectan y se corrigen?
  - ¿Cuánto tiempo por semana se dedica a "cuadrar" los dos sistemas?

---

## Datos de Tango a relevar (para entender la integración y para el MCP)
- Versión de Tango (ej.: Tango Gestión / Delta) y **módulos** que usan: Ventas, Tesorería, Contabilidad, Compras, Stock.
- ¿Quién lo administra? ¿Un proveedor externo?
- Motor de base de datos de Tango (suele ser SQL Server) y si está en el mismo servidor que A+W.
- ¿Hay alguien (proveedor de A+W o de Tango) que mantenga la interfaz entre los dos?

## Capturas a pedir
- La sesión de transmisión a Tango en A+W, si se puede ver.
- Import./export. Pagos, Administración de pagos a cuenta y Factura TPS.
- Ficha de cliente, pestaña 6 (datos financieros), con datos tapados.
- En Tango: el menú principal, para ver los módulos.

## Resultado de la entrevista
_(pegar aquí)_

## 🤖 Análisis
_(lo completa Claude)_
