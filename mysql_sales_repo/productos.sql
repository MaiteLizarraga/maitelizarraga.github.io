SELECT * FROM productos;

/* Elimino los espacios de los nombres de los productos para que sea más cómodo manipularlos */
UPDATE productos SET nombre_producto = REPLACE(nombre_producto, ' ', '');

/* Separo la columna precio_producto en dos, una columna con el precio numérico y la otra con la moneda */
/* Para ello creo una nueva columna, dejo el precio numérico en la existente, y añado una de moneda */
/* La columna moneda la muevo a después de precio_producto */
ALTER TABLE productos ADD COLUMN moneda TEXT;
ALTER TABLE productos MODIFY COLUMN moneda TEXT AFTER precio_producto;
UPDATE productos SET moneda = SUBSTRING_INDEX(SUBSTRING_INDEX(precio_producto, ' ', -1),' ',-1);
UPDATE productos SET precio_producto = SUBSTRING_INDEX(precio_producto, ' ', 1);

/* Hemos dicho en la tabla anterior que los precios estaban en euros, lo voy a poner todo en euros para simplificar, también los dólares */
UPDATE productos SET moneda = REPLACE(moneda, 'Dolares', 'euros');

/* Paso todos los decimales a punto en vez de dejarlos en coma */
UPDATE productos SET precio_producto = REPLACE(precio_producto, ',', '.');

/* Transformo los céntimos en euros dividiendo los valores entre 100, para ello convierto primero la columa a tipo alor INT */
ALTER TABLE productos MODIFY precio_producto INTEGER;
UPDATE productos SET precio_producto = (precio_producto / 100) WHERE moneda = 'centimos';
UPDATE productos SET moneda = REPLACE(moneda, 'centimos', 'euros');

/* PONER PRIMARY KEY */
ALTER TABLE `shop`.`productos` 
CHANGE COLUMN `id_producto` `id_producto` INT NOT NULL ,
CHANGE COLUMN `id_proveedor` `id_proveedor` INT NOT NULL ,
ADD PRIMARY KEY (`id_producto`, `id_proveedor`);
;