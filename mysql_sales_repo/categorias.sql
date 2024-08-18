SET SQL_SAFE_UPDATES = 0; /* me estaba saliendo un error de "safe mode" y no me dejaba hacer los updates */

SELECT * FROM shop.categorias;

ALTER TABLE categorias RENAME COLUMN `Nombre Categoria` TO nombre;
ALTER TABLE categorias RENAME COLUMN `Descripcion Categoria` TO descripcion;

UPDATE categorias SET nombre = LOWER(nombre);
UPDATE categorias SET descripcion = LOWER(descripcion);

/* PONER PRIMARY KEY */
ALTER TABLE shop.categorias CHANGE COLUMN `id_cat`
`id_cat` INT NOT NULL ,
ADD PRIMARY KEY (`id_cat`);
;