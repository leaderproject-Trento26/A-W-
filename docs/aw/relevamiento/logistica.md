# Relevamiento: Logística / Expedición

> Estado: 🟡 **Respuestas previas desde la documentación** · Falta la entrevista para validar · Orden: **1.º área**
> Para la entrevista usa las secciones 1 a 7 de la [PLANTILLA](PLANTILLA.md).

**Leyenda de fuentes**
- 📘 **Manual:** así lo prevé A+W. No significa que Trento lo use así.
- 📸 **Visto en Trento:** confirmado en las capturas del sistema real.
- ❓ **A validar:** hay que confirmarlo en la entrevista.

> **Dato importante.** El manual *Gestión de Documentos* (2019) casi seguro fue escrito **para Trento**:
> menciona la transmisión a **Tango**, que es la contabilidad de Trento, y su estatus 540 "Listo para envío"
> coincide con el texto que se ve en el sistema real. Sus respuestas tienen más peso que las del resto de los manuales.

## Lo que ya sabemos
- 📸 El pedido llega a Logística en estatus **540 – Pedido listo para envío**. Antes pasa por planta:
  430 lote organizado → 460 cortado → 485 templado.
- 📸 El tipo de documento **Expedición parcial** está activo, y la sesión *Documentos → Pedido → Expedición parcial* existe.
- 📸 Unos **300 pedidos por mes** (la GN de septiembre tiene 309).

## Lo que A+W ofrece para Logística
| Funcionalidad | Dónde está | ¿Trento la usa? |
|---|---|---|
| Condiciones de expedición (camión propio, retira cliente…) | Datos básicos → Expedición → Cond. expedición | ❓ La carpeta Expedición existe 📸 |
| **Rutas** con días, turno, hora de salida y costo por km | Datos básicos → Expedición → Rutas | ❓ |
| **Vehículos** con patente, chofer habitual, tara y peso máximo | Datos básicos → Expedición → Vehículos | ❓ |
| **Choferes** | Datos básicos → Expedición → Chofer | ❓ |
| Ruta y **orden de visita** por cliente | Ficha de cliente, pestaña 1 (Ruta1) | ❓ |
| Direcciones de entrega distintas (**filiales**) | Ficha de cliente → Funciones → Filial | ❓ |
| **Lista de rutas**: pedidos por fecha y ruta, y cambio masivo | Producción → Expedición → Lista de rutas | ❓ |
| **Armado de carga** con control de peso | Producción → Expedición → Expedición | ❓ |
| Impresión de remitos por lote | Producción → Expedición → Formularios | ❓ |
| Lista de carga, **acuse de recibo** y lista de caballetes | Producción → Expedición → Edición listas | ❓ |
| **Gestión de caballetes** | Sesión Caballetes | ❓ |
| Expedición parcial | Documentos → Pedido → Expedición parcial | ✅ 📸 existe y el tipo está activo |

---

## Preguntas con respuesta previa

### 1. ¿Cómo saben qué pedidos están listos para salir?
- 📘 **Manual:** el estatus **540 "Fin de producción / Listo para envío"** marca que el pedido terminó
  planta (*Gestión de Documentos*). El estatus puede cambiar de tres formas: por la lectura de retorno de
  producción (el escaneo BDE), por una tarea de WorkFlow o a mano.
- 📘 La **Lista de rutas** puede filtrar pedidos por **rango de estatus** y fecha de entrega.
- 📸 **Visto:** en la GN de septiembre aparecen pedidos en 540, así que el estatus se usa.
- ❓ **Validar:**
  - ¿Logística **mira el estatus 540 en A+W**, o se entera por aviso de planta?
  - ¿Quién pone el 540: el escaneo o una persona?

### 2. ¿Quién arma las rutas del día?
- 📘 **Manual:** A+W prevé este circuito:
  1. Cada cliente tiene una **ruta** (Ruta1) y un **rango**, que es el orden de visita dentro de la ruta.
  2. Cada ruta tiene **días de salida**, turno y hora.
  3. En *Producción → Expedición → Lista de rutas* se juntan los pedidos **por fecha de entrega y ruta**.
     Se pueden pasar a una GN para imprimir en orden.
  4. Se pueden **cambiar fecha o ruta en bloque** (Funciones → Ruta → Modificar datos de envío).
  5. Al cargar un pedido, A+W **avisa si la fecha de entrega no coincide con los días de la ruta** del cliente.
- ❓ **Validar:**
  - ¿Las rutas están cargadas en A+W?
  - ¿Los clientes tienen ruta asignada?
  - ¿Arman la salida en A+W o en Excel o papel?

### 3. ¿Cómo deciden qué pedido va en qué camión?
- 📘 **Manual:**
  - En *Producción → Expedición → Expedición* se eligen los pedidos de una GN y se asignan a un
    **vehículo y chofer**.
  - A+W suma **piezas y kg** y los compara con el **peso total** del vehículo. Si se pasa, el peso aparece **en rojo**.
  - El peso sale del **peso del producto** cargado en su ficha.
  - El vehículo y el chofer quedan grabados **en el pedido**.
- ❓ **Validar:**
  - ¿Usan esta pantalla?
  - ¿Los vehículos tienen cargado el peso máximo?
  - ¿Los productos tienen peso? Si no, el control de carga no funciona.

### 4. ¿Qué papeles lleva el chofer?
- 📘 **Manual:** A+W puede imprimir:
  - **Albarán, remito o guía** de cada pedido (*Formularios*). En el esquema de Trento, al imprimirlo el pedido pasa a **600 – Albarán de entrega**.
  - **Lista de carga:** qué caballetes subir al camión.
  - **Lista de acuse de recibo:** el cliente firma que recibió cada pedido y cantidad.
  - **Lista de caballetes:** caballetes enviados por chofer, ruta y cliente.
  - Una variante de 2011 menciona también "Lista de embalaje del transporte" y "Lista confirmación/entrega".
- ❓ **Validar:**
  - ¿Cuáles de estos papeles imprimen realmente?
  - ¿Usan remito de A+W o de Tango?

### 5. ¿Cómo se confirma la entrega y cómo vuelve la información?
- 📘 **Manual:** A+W **no tiene un registro de "entregado"**:
  - La confirmación es el **acuse de recibo en papel**.
  - El estatus 600 se pone **al imprimir** el albarán, **no al entregar**.
  - Ningún manual describe cómo se carga en A+W que la entrega se hizo.
- 💡 **Conclusión:** es muy probable que **A+W no sepa si un pedido fue entregado**. Este es el hueco que
  cubre **Trento Entregas**: confirmación digital, foto o firma y encuesta.
- ❓ **Validar:**
  - ¿Qué hacen con el papel firmado?
  - ¿Alguien marca algo en A+W o en Tango?
  - ¿Cómo sabe Ventas que el cliente recibió?

### 6. ¿Qué pasa si una entrega falla?
- 📘 **Manual:** no hay un proceso de "entrega fallida". Solo hay dos herramientas relacionadas:
  - Cambiar **fecha o ruta** del pedido (Lista de rutas → Modificar datos de envío).
  - El tipo de documento **Reclamación** (activo en Trento 📸), para incidencias con el cliente.
- ❓ **Validar:**
  - ¿Cómo registran una rotura o un cliente ausente?
  - ¿La rotura genera una reclamación o un pedido de reposición?

### 7. ¿Controlan los caballetes que quedan en clientes?
- 📘 **Manual:** A+W tiene una **Gestión de caballetes** separada de los pedidos:
  - Tipos y números de caballete.
  - **Salida** a un cliente, con fecha, chofer y albarán.
  - **Entrada**, cuando el caballete vuelve.
  - **Historial** de movimientos.
  - **Aviso impreso** para clientes que no los devuelven.
  - Aparte, en producción se asignan caballetes a las posiciones para la lista de carga.
- ❓ **Validar:**
  - ¿La usan?
  - ¿Cuántos caballetes hay afuera?
  - ¿Se pierden?

### 8. ¿Hay entregas parciales? ¿Cómo las gestionan?
- 📘 **Manual:**
  - La expedición parcial se **habilita por cliente** (ficha de cliente, pestaña 2 "Pedido").
  - Al hacerla, A+W **crea un pedido nuevo** con la numeración del contador de expedición parcial.
  - En el armado de carga, los valores aplican a **todo el pedido**. Para mandar solo algunas posiciones
    hay que crear una entrega parcial.
- 📸 **Visto:** la sesión existe y el tipo de documento está **activo**, así que es probable que se use.
- ❓ **Validar:**
  - ¿Con qué frecuencia la usan?
  - ¿Quién la crea: Logística o Ventas?

### 9. ¿Qué estatus cambia Logística en A+W?
- 📘 **Manual (esquema de Trento):** 540 listo para envío → **600 albarán de entrega** (al imprimir) →
  750 factura → 800 contabilidad. En otra implementación existía un grupo de usuarios **DESPACHO** que
  marcaba "listo para despacho" a mano.
- ❓ **Validar:**
  - ¿Logística imprime el remito desde A+W, y con eso pasa a 600?
  - ¿Tienen usuario propio en A+W?

### 10. ¿Qué información les gustaría ver en el celular del chofer?
- 📘 **Manual:** no aplica, pero A+W **ya tiene los datos** que necesitaría la app:
  - Ruta y orden de visita.
  - Dirección de entrega (filial).
  - Piezas, m² y kg por pedido.
  - Vehículo y chofer asignados.
  - Caballetes.
- ❓ **Validar con el chofer:** ¿qué le falta hoy? ¿Qué llamadas o mensajes hace durante el reparto?

---

## Capturas a pedir durante la entrevista
- Datos básicos → Expedición → Rutas, Vehículos y Chofer. Tapa las patentes si prefieres.
- Producción → Expedición → Lista de rutas y Expedición (si la usan).
- Un remito o guía impreso, anonimizado.

## Resultado de la entrevista
_(pegar aquí las respuestas usando las secciones 1 a 7 de la plantilla)_

## 🤖 Análisis
_(lo completa Claude después de la entrevista)_
