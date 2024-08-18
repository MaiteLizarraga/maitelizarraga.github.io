SET SQL_SAFE_UPDATES = 0;

/* modifico los nombres de las variables para que sea más cómodo manipularlas */
ALTER TABLE facturacion RENAME COLUMN Descuento TO descuento;
ALTER TABLE facturacion RENAME COLUMN `Precio Total(euros)` TO precio_total_euros;

/* elimino el caracter extraño en la columna descuento */
UPDATE facturacion SET descuento = REPLACE(descuento, 'Â', '');

/* Paso todos los decimales a punto en vez de dejarlos en coma */
UPDATE facturacion SET precio_total_euros = REPLACE(precio_total_euros, ',', '.');

/* Paso las fechas de formato texto a formato datetime */
ALTER TABLE `shop`.`facturacion` 
CHANGE COLUMN `fecha` `fecha` DATETIME NULL DEFAULT NULL ;

/* PONER PRIMARY KEY */
ALTER TABLE `shop`.`facturacion` 
CHANGE COLUMN `id_factura` `id_factura` INT NOT NULL ,
ADD PRIMARY KEY (`id_factura`);
;