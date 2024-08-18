SELECT * FROM shop.ventas;

/* Separo la columna venta_precio_ud en dos, una columna con el precio numérico y la otra con la moneda */
/* Para ello creo una nueva columna, dejo el precio numérico en la existente, y añado una de moneda */
/* La columna moneda la muevo a después de venta_precio_ud */
ALTER TABLE ventas ADD COLUMN moneda TEXT;
ALTER TABLE ventas MODIFY COLUMN moneda TEXT AFTER venta_precio_ud;
UPDATE ventas SET moneda = SUBSTRING_INDEX(SUBSTRING_INDEX(venta_precio_ud, ' ', -1),' ',-1);
UPDATE ventas SET venta_precio_ud = SUBSTRING_INDEX(venta_precio_ud, ' ', 1);

/* Hemos dicho en la tabla anterior que los precios estaban en euros, lo voy a poner todo en euros para simplificar, también los dólares */
UPDATE ventas SET moneda = REPLACE(moneda, 'Dolares', 'euros');

/* Transformo los céntimos en euros dividiendo los valores entre 100, para ello convierto primero la columa a tipo alor INT */
ALTER TABLE ventas MODIFY venta_precio_ud INTEGER;
UPDATE ventas SET venta_precio_ud = (venta_precio_ud / 100) WHERE moneda = 'centimos';
UPDATE ventas SET moneda = REPLACE(moneda, 'centimos', 'euros');

/* Paso todos los decimales a punto en vez de dejarlos en coma */
UPDATE ventas SET precio_unitario = REPLACE(precio_unitario, ',', '.');
UPDATE ventas SET precio_facturado = REPLACE(precio_facturado, ',', '.');

/* Veo que la columna de precio_unitario está repetida, quito la de venta_precio_ud */
ALTER TABLE ventas DROP COLUMN venta_precio_ud;

/* PONER PRIMARY KEY */
ALTER TABLE `shop`.`ventas` 
CHANGE COLUMN `id_venta` `id_venta` INT NOT NULL ,
ADD PRIMARY KEY (`id_venta`);
;