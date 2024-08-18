SELECT * FROM shop.proveedores;

/* modifico los nombres de las variables para que sea más cómodo manipularlas */
ALTER TABLE proveedores RENAME COLUMN Nombre_proveedor TO nombre_proveedor;
ALTER TABLE proveedores RENAME COLUMN `Telefono Proveedor` TO tel_proveedor;
ALTER TABLE proveedores RENAME COLUMN `Direccion Proveedor` TO dir_proveedor;

/* separo las direcciones de los proveedores en calle, número, ciudad y comunidad autónoma */
/* para ello creo 4 nuevas columnas: calle, numero, ciudad y com_autonoma */
ALTER TABLE proveedores ADD COLUMN calle TEXT;
ALTER TABLE proveedores ADD COLUMN numero TEXT; /* la dejo tipo text porque podría haber un s/n */
ALTER TABLE proveedores ADD COLUMN ciudad TEXT;
ALTER TABLE proveedores ADD COLUMN com_autonoma TEXT;

UPDATE proveedores SET calle = SUBSTRING_INDEX(dir_proveedor, ',', 1);
UPDATE proveedores SET numero = SUBSTRING_INDEX(SUBSTRING_INDEX(dir_proveedor, ',', 2),',',-1);
UPDATE proveedores SET ciudad = SUBSTRING_INDEX(SUBSTRING_INDEX(dir_proveedor, ',', 3),',',-1);
UPDATE proveedores SET com_autonoma = SUBSTRING_INDEX(SUBSTRING_INDEX(dir_proveedor, ',', -1),',',-1);

UPDATE proveedores SET calle = TRIM(calle);
UPDATE proveedores SET numero = TRIM(numero);
UPDATE proveedores SET ciudad = TRIM(ciudad);
UPDATE proveedores SET com_autonoma = TRIM(com_autonoma);

/* y por último elimino la columna dir_proveedor que ya no necesito */
ALTER TABLE proveedores DROP COLUMN dir_proveedor;

/* PONER PRIMARY KEY */
ALTER TABLE `shop`.`proveedores` 
CHANGE COLUMN `id_proveedor` `id_proveedor` INT NOT NULL ,
ADD PRIMARY KEY (`id_proveedor`);
;