SET SQL_SAFE_UPDATES = 0; /* me estaba saliendo un error de "safe mode" y no me dejaba hacer los updates */

SELECT * FROM shop.clientes;

/* modifico los nombres de las variables para que sea más cómodo manipularlas */
ALTER TABLE clientes RENAME COLUMN Nombre_cliente TO nombre_cliente;
ALTER TABLE clientes RENAME COLUMN `Telefono Cliente` TO tel_cliente;
ALTER TABLE clientes RENAME COLUMN `Direccion Cliente` TO dir_cliente;

/* lo iba a poner todo en minúscula, pero finalmente creo que queda mejor en mayúscula 
UPDATE clientes SET nombre_cliente = LOWER(nombre_cliente);
UPDATE clientes SET tel_cliente = LOWER(tel_cliente);
UPDATE clientes SET dir_cliente = LOWER(dir_cliente); */

/* elimino los espacios en blanco de la columna de los teléfonos */
UPDATE clientes SET tel_cliente = REPLACE(tel_cliente, ' ', '');

/* añado dos columnas para guardar los dos teléfonos de los clientes */
ALTER TABLE clientes ADD COLUMN tel_cliente_1 TEXT;
ALTER TABLE clientes ADD COLUMN tel_cliente_2 TEXT;

/* meto el primer número de teléfono en la primera columna y el segundo en la segunda */
UPDATE clientes SET tel_cliente_1 = SUBSTRING(tel_cliente, 1,9);
UPDATE clientes SET  tel_cliente_2 = SUBSTRING(tel_cliente, -9);

/* elimino los números de teléfono duplicados */
UPDATE clientes SET tel_cliente_2 = '' WHERE tel_cliente_2 = tel_cliente_1;

/* elimino la columna de teléfonos original que ya no necesito */
ALTER TABLE clientes DROP COLUMN tel_cliente;

/* ahora separo las direcciones de los clientes en calle, número, ciudad y comunidad autónoma */
/* para ello creo 4 nuevas columnas: calle, numero, ciudad y com_autonoma */
ALTER TABLE clientes ADD COLUMN calle TEXT;
ALTER TABLE clientes ADD COLUMN numero TEXT; /* la dejo tipo text porque podría haber un s/n */
ALTER TABLE clientes ADD COLUMN ciudad TEXT;
ALTER TABLE clientes ADD COLUMN com_autonoma TEXT;

UPDATE clientes SET calle = SUBSTRING_INDEX(dir_cliente, ',', 1);
UPDATE clientes SET numero = SUBSTRING_INDEX(SUBSTRING_INDEX(dir_cliente, ',', 2),',',-1);
UPDATE clientes SET ciudad = SUBSTRING_INDEX(SUBSTRING_INDEX(dir_cliente, ',', 3),',',-1);
UPDATE clientes SET com_autonoma = SUBSTRING_INDEX(SUBSTRING_INDEX(dir_cliente, ',', -1),',',-1);

/* y por último elimino la columna dir_cliente que ya no necesito */
ALTER TABLE clientes DROP COLUMN dir_cliente;

/* me aparece un espacio en blanco antes del número de calle, de la ciudad y de la comunidad autónoma, los quito */ 
UPDATE clientes SET numero = TRIM(numero);
UPDATE clientes SET ciudad = TRIM(ciudad);
UPDATE clientes SET com_autonoma = TRIM(com_autonoma);

/* PONER PRIMARY KEY */
ALTER TABLE `shop`.`clientes` 
CHANGE COLUMN `id_cliente` `id_cliente` INT NOT NULL ,
ADD PRIMARY KEY (`id_cliente`);
;