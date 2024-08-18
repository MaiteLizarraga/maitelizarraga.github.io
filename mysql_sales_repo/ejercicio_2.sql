/* a) Obtener los nombres de los clientes cuya dirección sea en la Comunidad de Madrid. */
SELECT nombre_cliente
FROM shop.clientes
WHERE com_autonoma LIKE '%Madrid';

/* b) Obtener la información completa del Proveedor (código, nombre, dirección, teléfono) en caso de no disponer de información de ciudad o comunidad, mostrar
el valor como nulo. Ignorar los identificadores, salvo los del proveedor. */
SELECT id_proveedor, nombre_proveedor, tel_proveedor, calle, numero, ciudad, com_autonoma
FROM shop.proveedores;

/* c) Obtener la información completa del cliente, excepto el teléfono, ignorando aquellos identificadores salvo el del cliente,
(código, nombre, dirección, uno de los teléfonos disponibles), de aquellos cuya fecha de factura sea la más antigua del sistema.
En caso de no disponer de información de la factura para ese cliente, debemos ignorar el registro, al igual que si no tenemos información de la ciudad o comunidad. */
	/* NOTA MAITE: ATENCIÓN, INFO CONTRADICTORIA EN EL ENUNCIADO, "EXCEPTO TELÉFONO" Y "UNO DE LOS TELÉFONOS DISPONIBLES". */
SELECT sc.id_cliente, sc.nombre_cliente, sc.calle, sc.numero, sc.ciudad, sc.com_autonoma, sc.tel_cliente_1, MIN(sf.fecha) AS factura_mas_antigua
FROM shop.clientes sc LEFT JOIN shop.facturacion sf USING (id_cliente)
WHERE sf.id_factura IS NOT NULL AND sc.ciudad IS NOT NULL AND sc.com_autonoma IS NOT NULL
GROUP BY id_cliente, nombre_cliente, calle, numero, ciudad, com_autonoma, tel_cliente_1
ORDER BY factura_mas_antigua
LIMIT 1;

/* d) Obtener aquellos productos que únicamente comercialice un único proveedor. Se desea conocer la información completa del producto
incluida la información sobre la categoría a la que pertenece. */
SELECT sp.id_producto, sp.nombre_producto, sp.stock_producto, sp.precio_producto, sp.moneda, sp.id_cat, sct.nombre AS nombre_categoria
FROM shop.productos sp INNER JOIN shop.categorias sct USING (id_cat)
GROUP BY sp.id_producto, sp.nombre_producto, sp.stock_producto, sp.precio_producto, sp.moneda, sp.id_cat, sct.nombre
HAVING COUNT(sp.id_producto) = 1
ORDER BY sp.id_producto; /* el producto sólo aparece una vez en la tabla de productos */

/* e) Contar el número de productos en cada factura. */
SELECT sf.id_factura, COUNT(sv.id_producto) AS productos_en_factura
FROM shop.facturacion sf INNER JOIN shop.ventas sv USING (id_factura)
GROUP BY sf.id_factura;

/* f) Obtener el nombre del producto que se haya comprado alguna vez cómo único elemento dentro de una compra. Se necesita el identificador
y el nombre de forma única. */ /* PODRIA HABER HECHO UNA SUBCONSULTA PERO HE PREFERIDO HACERLO ASI AUNQUE ES ALGO QUE NO HEMOS VISTO */
WITH factura_un_producto AS (
SELECT sv.id_factura, COUNT(sv.id_factura) AS productos_por_factura
FROM shop.ventas sv
GROUP BY sv.id_factura
HAVING productos_por_factura = 1
ORDER BY productos_por_factura ASC)

SELECT sv.id_factura, sv.id_producto, sp.nombre_producto
FROM factura_un_producto
INNER JOIN shop.ventas sv USING (id_factura)
INNER JOIN shop.productos sp USING (id_producto);

/* g) Escribir la consulta para obtener los clientes, basta con conocer su nombre, que han comprado más de tres productos en alguna de sus compras.
Luego ordena los resultados de mayor número de productos a menor. */
SELECT sc.nombre_cliente
FROM shop.clientes sc INNER JOIN shop.ventas sf USING (id_cliente)
GROUP BY sc.nombre_cliente
HAVING COUNT(sf.id_producto) > 3;

/* h) Escribir la consulta que nos permita disponer de la información necesaria para conocer los nombres de los clientes que aún no hayan ejecutado ninguna compra. */
/* NO DA NADA COMO RESULTADO PORQUE NO TENEMOS NINGÚN CLIENTE SIN COMPRAS EN NUESTRO DATASET */
SELECT DISTINCT sc.nombre_cliente
FROM shop.clientes sc LEFT JOIN shop.ventas sv USING (id_cliente)
WHERE sv.id_factura IS NULL;

/* i) Escribir la consulta que nos permita disponer del nombre e identificador de los clientes que han efectuado alguna venta,
pero aún no se dispone de información de su factura. */
/* NO DA NADA COMO RESULTADO PORQUE EN NUESTRO DATASET TODAS LAS VENTAS TIENEN FACTURA */
SELECT sc.id_cliente, sc.nombre_cliente
FROM shop.clientes sc LEFT JOIN shop.facturacion sf USING (id_cliente)
WHERE id_factura IS NULL;

/* j) Se desea contactar con aquellos proveedores, mediante correo postal, si alguno de sus productos cumple las siguientes condiciones: */
	/* 1. Su precio sea menor de 5 euros y disponga de menos de 50 unidades. */
SELECT DISTINCT sprov.nombre_proveedor, sprov.calle, sprov.numero, sprov.ciudad, sprov.com_autonoma
FROM shop.proveedores sprov INNER JOIN shop.productos sprod USING (id_proveedor)
WHERE sprod.precio_producto < 5 AND sprod.stock_producto < 50;
        
	/* 2. Su precio esté entre 100 y 500 euros y disponga entre 10 y 20 unidades. */
SELECT DISTINCT sprov.nombre_proveedor, sprov.calle, sprov.numero, sprov.ciudad, sprov.com_autonoma
FROM shop.proveedores sprov INNER JOIN shop.productos sprod USING (id_proveedor)
WHERE (sprod.precio_producto BETWEEN 100 AND 500) AND (sprod.stock_producto BETWEEN 10 AND 20);
    
	/* 3. Su precio sea mayor de 500 euros y disponga de menos de 6 unidades. */
SELECT DISTINCT sprov.nombre_proveedor, sprov.calle, sprov.numero, sprov.ciudad, sprov.com_autonoma
FROM shop.proveedores sprov INNER JOIN shop.productos sprod USING (id_proveedor)
WHERE sprod.precio_producto > 500 AND sprod.stock_producto < 6;
    
/* k) Se desea obtener un listado de las ventas con el siguiente detalle: */
	/* 1. Fecha de la venta, total de la compra y descuento aplicado. */
SELECT DISTINCT sf.fecha, sf.precio_total_euros, sf.descuento
FROM shop.facturacion sf;

	/* 2. Del producto se desea conocer el código del producto, su nombre y la descripción de la categoría a la que pertenece. */
SELECT DISTINCT sp.id_producto, sp.nombre_producto, sc.descripcion
FROM shop.productos sp INNER JOIN shop.categorias sc USING (id_cat)
ORDER BY sp.id_producto;
    
	/* 3. Sobre el proveedor del producto solo interesa conocer la web. */
SELECT web
FROM shop.proveedores;

	/* 4. Del cliente se quiere conocer su nombre, su código y la ciudad donde vive. */
SELECT nombre_cliente, id_cliente, ciudad
FROM shop.clientes;
    
/* l) Obtener el nombre del proveedor junto con el total de productos que tiene.
Se quiere renombrar el valor de conteo por “total_productos”, y obtener el resultado ordenado de menor a mayor. */
SELECT sprov.nombre_proveedor, COUNT(sprod.id_producto) AS num_productos_proveedor
FROM shop.proveedores sprov INNER JOIN shop.productos sprod USING (id_proveedor)
GROUP BY nombre_proveedor;

/* m) Obtener el nombre del cliente que más gasto haya tenido en todo el histórico del que se dispone. */
SELECT sc.nombre_cliente
FROM shop.clientes sc INNER JOIN shop.ventas sv USING (id_cliente)
GROUP BY sc.nombre_cliente
HAVING SUM(sv.precio_facturado)
ORDER BY SUM(sv.precio_facturado) DESC
LIMIT 1;

/* n) Obtener el nombre del cliente y su teléfono, concatenando los distintos teléfonos en una misma columna, 
separado por comas, mostrar el valor NULL en caso de no disponer de teléfonos de contactos. */
SELECT nombre_cliente, CONCAT_WS(',', NULLIF(tel_cliente_1, ''), NULLIF(tel_cliente_2, '')) AS telefonos
FROM shop.clientes;