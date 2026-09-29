# Resumen de los manuales de A+W / ALFAK recibidos

Manuales internos de capacitación, casi todos de 2013 a 2021, escritos por el consultor de la implementación.
**ALFAK es el nombre anterior de A+W Business**; es el mismo sistema.
Algunos manuales son genéricos: el de IVA, por ejemplo, habla del cambio en España de 2012, y el de
divisas usa euros. No todo lo que describen tiene que estar configurado igual en Trento.

Los originales no están en el repo; aquí solo va el resumen. Si quieres guardarlos, se pueden agregar
en `docs/aw/manuales/`.

## Relevancia para el MCP y para Trento Entregas
| Nivel | Manuales |
|---|---|
| ⭐⭐⭐ Clave | Modelo de datos · Resumen de flujo de programa (estatus VITRUM) · Gestión de documentos · Expedición (A+W Business 6) · Gestión de expediciones 2011 |
| ⭐⭐ Útil | Introducción AWBusiness · Gestión de clientes · Gestión de productos · Almacén · Gerente de producción · Límite de crédito · Estadísticas · Archivar documentos · Caballetes · Filiales · Obras · Permisos |
| ⭐ Contexto | Alternativas · Barrotillos · Divisas · Pagos anticipados · Múltiplos · Otros recargos · Modificaciones puntuales · Macros · Inventario · IVA · Desplazar columnas · Excel Line Import · Optimización de ofertas |

Total: **30 documentos** recibidos (29 Word y 1 PDF).

---

## ⭐⭐⭐ Manuales clave

### Modelo de datos
- Tablas en SQL Server, esquema `SYSADM`, organizadas por módulo:
  - `KU` clientes, `LI` proveedores, `BA` productos.
  - `PR` precios, `RB` descuentos.
  - `BW` documentos, `KA` tablas varias.
- Detalle completo en [`MODELO-DATOS.md`](MODELO-DATOS.md).

### Resumen de flujo de programa ("VITRUM – Flujo de Ventas", 2012)
- Flujo de estatus **real de una implementación**, con numeración 1 a 170: oferta → pedido → caja →
  revisión de medidas → hoja de producción → producción → **66 fin de producción → 67 control de calidad →
  68 listo para despacho → 71 guía de remisión** → 95 factura → 100 contabilidad.
- Cada paso está restringido a un **grupo de usuarios**: VENTAS, CAJA, FÁBRICA, DESPACHO o SISTEMAS.
- Una oferta rechazada (23) exige cargar un motivo en "Categoría".
- Es el esquema más probable para Trento, pero hay que confirmarlo. Tabla completa en [`MODELO-DATOS.md`](MODELO-DATOS.md).

### Gestión de documentos
- ⭐ **Probablemente escrito para Trento.** Menciona los estatus 235 y 240 de transmisión a **Tango**,
  que es la contabilidad de Trento, y su 540 "Listo para envío" coincide con el sistema real.
  Por eso su flujo de estatus es la mejor referencia para Trento.
- **5 documentos maestros:** Oferta (cotización), Pedido (venta), Abono (nota de crédito),
  Consulta (presupuesto de compra) y Encargo (compra).
- Todo se controla con **estatus numéricos**. Cada tipo tiene su flujo; el del pedido va de 1 (creado)
  a 900 (archivado), pasando por 540 (listo para envío), 600 (albarán) y 750 (facturado).
- Formas de cambiar el estatus:
  1. Al imprimir.
  2. Con una sesión de transmisión (a producción, a contabilidad…).
  3. Con el retorno de producción (pedido cortado, pulido…).
  4. Con el WorkFlow.
  5. A mano, solo usuarios autorizados.
- Todo documento tiene **Cabecera** (cliente, fecha de entrega, referencia), **Posiciones**
  (producto, piezas, ancho, alto) y **Lista de piezas** (composición y procesos; F9 formas, F10 barrotillos).
- **Edición** = imprimir documentos. Es *directa* si se hace desde dentro del documento, y *estándar*
  si se hace sobre una gestión de números.
- **Gestión de números (GN)** = un grupo de documentos armado con la Búsqueda para aplicarles una
  acción en bloque. Esto explica la pestaña **"GN pedido"** de la captura.

### Expedición (A+W Business 6) y Gestión de expediciones (2011)
- **Datos básicos → Expedición** tiene:
  - **Cond. expedición:** camión propio, retira el cliente, etc.
  - **Rutas:** días Lu–Do, turno, hora de salida, €/km, clave externa.
  - **Vehículos:** patente, chofer habitual, tara, peso total.
  - **Chofer**
  - **Rutas aduana** y **Nrs. aduana**
- En cada cliente se define su **ruta y rango**. El rango es el orden en que se lo visita dentro de la ruta.
- En el menú **Producción → Expedición**:
  1. **Lista de rutas:** junta los pedidos por fecha de entrega y ruta, filtrando por estatus.
     Permite cambiar la ruta o la fecha de muchos pedidos a la vez (*Funciones → Ruta → Modificar datos de envío*).
  2. **Expedición:** asigna los pedidos a un **vehículo y chofer**, y muestra piezas y kg frente a la
     carga máxima. Si se pasa, el peso aparece **en rojo**.
  3. **Formularios:** imprime los albaranes de la GN.
  4. **Edición listas:** lista de carga (qué caballetes subir), **lista de acuse de recibo** (el cliente
     firma la entrega) y lista de caballetes. Antes hay que haber asignado caballetes o bastidores a las posiciones.
- **Relación con Trento Entregas:** la app digitaliza justamente la *lista de acuse de recibo* y el
  seguimiento de rutas, choferes y vehículos.

---

## ⭐⭐ Manuales útiles

### Introducción a AWBusiness
- Pantalla con menú lateral de módulos, **Favoritos** y cinta con los botones Nuevo, Borrar, Grabar,
  Primero, Anterior, Siguiente, Último y Filtro.
- Permite **multisesión**, es decir, varias pestañas abiertas. Por eso se ven pestañas abajo en la captura.
- La parrilla de posiciones se configura por usuario y por tipo de documento.
- Los ejercicios del curso mencionan: copiar oferta a pedido, **expedición parcial**, **reclamaciones**,
  alternativas, macros y **Crystal Reports**. Coincide con los tipos de documento activos en Trento.

### Gestión de clientes
- **Datos iniciales**, que hay que cargar antes que los clientes: provincias, sectores (solo sirven de filtro),
  grupos de clientes (afectan precios y descuentos), condiciones y formas de pago, **rutas de expedición** e IVA.
- **Ficha de cliente:**
  - 1 Dirección: número, matchcode, nombre, dirección, provincia, sector, grupo, **Ruta1**.
  - 2 Pedido: factura agrupada, **expedición parcial**, facturación parcial.
  - 3 Empleados/filiales.
  - 6 Datos financieros: NIF/RUC/RUT, condición de pago, código de bloqueo.
  - 7 Crédito.
  - 8 Ventas: comercial.
- **Clasificadores** = campos personalizados (fecha, número o texto) que se agregan al cliente.
- La **ruta del cliente** también ordena el vidrio dentro de producción.

### Gestión de productos
- **Familia de producto:** árbol de 3 niveles (ej.: `B**` → `B2*` → `B21`), obligatorio en todo producto.
  Se usa para estadísticas y descuentos.
- **Tipo de producto:** estándar de A+W, no se pueden crear nuevos.
- **Grupo de producto:** los personalizados van del código 1000 en adelante.
- Ficha de producto: número (hasta 8 dígitos), matchcode, nombres, espesor, **peso**, unidad,
  capa o estructura, tablas de precio y tipo de obtención.
- Tipos de obtención:
  - **000 – Producción:** templado, laminado propio, procesos.
  - **002 – Sacado de almacén:** monolítico, laminado comprado.
- La numeración de productos se definió en un Excel `PRODUCTOS_001.xlsx`.
  Puede servir para el catálogo de láminas del prototipo.

### Almacén
- Ubicaciones de 4 niveles.
- El vidrio se controla por **hoja entera** y los herrajes por pieza.
- Movimientos, transferencias, historial y búsqueda (stock, reservado y encargado).
- **Encargo almacén** = compra automática según mínimo y factor de compra.
- Inventario: lista (máximo 5.000) → impresión → evaluación de existencias → conteo → cierre.
- Esto explica el tipo de documento **"Encargo del almacén"** activo en Trento.

### Gerente de producción (AWB Pro)
- Módulo de producción integrado:
  1. **Carga GN** traspasa los pedidos.
  2. Se crea una **tarea**.
  3. Se optimiza el corte eligiendo las medidas de hoja.
  4. Se imprimen la ocupación de caballetes, los planos de corte y las etiquetas, y se generan los códigos de corte.
- Estados de la tarea: planificado en general → en detalle → optimizada → aprobado → acabado.

### Límite de crédito
- Límite 1 y 2 por cliente, con un tipo de control.
- El "retorno de saldos" viene de la contabilidad externa. El campo "Pedidos" suma los pedidos en curso.
- Estatus especial "límite de crédito excedido": 952, o 170 en el esquema VITRUM.

### Estadísticas
Hay 3 fuentes:
1. **Info Pedidos:** al día, sin necesidad de facturar. Pestañas Introducido, Producido, Facturado y Abierto.
2. **Estadística de ventas:** requiere transmitir los pedidos; se consulta por mes o año, no por día.
3. **Crystal Reports:** listados a medida.

Ojo al contar piezas: la estadística puede contar solo las posiciones, o incluir también la lista de piezas.
Un DVH (doble vidriado) cuenta como 1 pieza en la posición, pero como 4 si se incluyen sus componentes.

### Archivar documentos
- Cada año los documentos viejos pasan a una **base de datos de archivo** y se borran de la principal.
- **Para el MCP:** los pedidos antiguos pueden no estar en la base principal.

### Caballetes
- Registro de caballetes: tipos, números, salida a cliente con fecha, chofer y albarán, entrada o devolución e historial.
- Permite imprimir **avisos a clientes** que no devuelven caballetes.

### Filiales
- Una filial es una ficha de cliente hija, con **dirección de entrega o de facturación distinta**.
  Sugieren numerarlas desde 200000.
- **Para Trento Entregas:** la dirección de entrega real puede estar en la filial, no en el cliente principal.

### Obras
- Se crea la obra, se asigna a un cliente con vigencia y se cargan productos con m², piezas e importe pactados.
- En el pedido se elige en la pestaña 4 (Condiciones).
- Tabla `KA_OBJEKT`.

### Permisos
- Los permisos se dan por **grupo de usuario** (ej.: VENTAS) y por "programa" numerado
  (ej.: `0002 – Documentos – Pedido – Pedido`).
- Se pueden bloquear los cambios de estatus manuales, los precios o descuentos, los documentos a partir
  de cierto estatus y la impresión de facturas.

---

## ⭐ Contexto funcional (resumen corto)

| Manual | Qué explica |
|---|---|
| Alternativas | Crear o modificar ofertas y pedidos reemplazando componentes (ej.: laminado 3+3 por 4+4) y recalcular precios |
| Barrotillos | Parámetros (flecha, cruceta, fresado) e impresión del despiece de barrotillos |
| Divisas | Moneda nacional frente a extranjera por cliente; tipo de cambio fijado en el pedido o en la factura |
| Pagos anticipados | Módulo licenciado: crea un pedido de pago anticipado (posición 999) y descuenta el importe en el pedido original. En Trento el tipo "Pago anticipado" está **bloqueado** |
| Múltiplos | Jerarquía de redondeos: ficha de cliente < producto < tabla de precio < descuentos < tabla de cliente |
| Otros recargos | Recargos por tipos límite (m², canto…) asignados en las tablas de precio |
| Modificaciones puntuales | Cambiar múltiplos y superficie mínima, y desactivar recargos (banderas rojas C y O) en un pedido |
| Macros | Guardar una posición de pedido con nombre para reutilizarla |
| Inventario | Almacén → Inventario: lista, conteo, gestión de inventario y cierre |
| Modificación de IVA | Cómo pasar al nuevo IVA (caso España 2012); crear un código nuevo, no modificar el existente |
| Desplazar columnas | Reordenar columnas de la Gestión de números por usuario |
| Excel Line Import | Módulo licenciado (A+W Business 6.4 o superior): pegar desde Excel las piezas, anchos, altos y referencias como posiciones de un pedido |
| Optimización de ofertas | Módulo licenciado 151: optimizar el corte de una oferta con el Production Manager |
