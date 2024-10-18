-- Añadir columnas:

ALTER TABLE nombre_tabla
	ADD COLUMN nombre tipo_dato restricciones; -- (no necesario)
    
-- Eliminar columnas:
ALTER TABLE nombre_tabla
	DROP COLUMN nombre_columna; -- OJO: se eliminan todos los registros
    
-- Cambiar tipo datos:
ALTER TABLE nombre_tabla
	MODIFY COLUMN nombre_columna tipo_dato;
    
-- Cambiar solo el nombre:
ALTER TABLE nombre_tabla
	RENAME COLUMN nombre_actual TO nombre_nuevo;

-- Cambiar el nombre y el tipo de dato:
ALTER TABLE nombre_tabla
	CHANGE nombre_actual nombre_nuevo tipo_dato;
    
-- Eliminar tabla:
DROP TABLE nombre_tabla, nombre_tabla2;
DROP TABLE IF EXISTS nombre_tabla;

-- Inserción datos:

INSERT INTO nombre_tabla (col1, col2, col3)
	VALUES(val1, val2, val3),
		  (val1, "val2", val3);

-- Resetear auto_increment:
ALTER TABLE nombre_tabla
	AUTO_INCREMENT = 1;
	
-- Insertar datos de todas las columnas:
INSERT INTO nombre_tabla -- no es necesario especificar columnas
	VALUES (val1, val2, val3);

-- Borrar:
DELETE FROM nombre_tabla
	WHERE columna = condición;

-- Creación de tabla en base a otra:
CREATE TABLE customer_destroy
	SELECT *
		FROM customers;


--EJERCICIOS modulo-2-leccion-06-modificacion-insercion-datos

-- Ejercicio 1: Renombra la tabla t1 a t2.

ALTER TABLE t1 RENAME t2;

-- Ejercicio 2: Cambia la columna `a` de tipo `INTEGER` a tipo `TINYINT NOT NULL` (manteniendo el mismo nombre para la columna).

ALTER TABLE t2 MODIFY a TINYINT NOT NULL;

-- Ejercicio 3: Cambia la columna `b` de tipo `CHAR` de 10 caracteres a `CHAR` de 20 caracteres. Además, renombra la columna como `c`.

ALTER TABLE t2 CHANGE b c CHAR(20);

-- Ejercicio 4: Añade una nueva columna llamada `d` de tipo `TIMESTAMP`.

ALTER TABLE t2 ADD d TIMESTAMP;

-- Ejercicio 5: Elimina la columna `c` que definiste en el ejercicio 3.

ALTER TABLE t2 DROP COLUMN c;

-- Ejercicio 6: Crea una tabla llamada `t3` idéntica a la tabla `t2` (de manera automática, no definiéndola columna a columna).

CREATE TABLE t3 LIKE t2;

-- Ejercicio 7: Elimina la tabla original `t2` y en otra sentencia renombra la tabla `t3` como `t1`.

DROP TABLE t2;
ALTER TABLE t3 RENAME t1;

-- Ejercicio 8: Realiza una inserción de datos sobre la tabla `customers_mod`

INSERT INTO customers_mod (customer_number,customer_name, contact_last_name, contact_first_name, phone,address_line1,address_line2, city, state, postal_code, country, sales_rep_employee_number, credit_limit)
VALUES (343,'Adalab','Rodriguez','Julia',672986373,'Calle Falsa 123','Puerta 42','Madrid','España',28000,'España',15,20000000);

-- Ejercicio 9: Realiza una inserción de datos sobre la tabla `customers_mod`

INSERT INTO customers_mod (customer_number,customer_name, contact_last_name, contact_first_name, phone,address_line1,address_line2, city, state, postal_code, country, sales_rep_employee_number, credit_limit)
VALUES (344,'La pegatina After','Santiago','Maricarmen',00000000,'Travesia del rave',NULL,'Palma de mallorca',NULL,07005,'España',10,45673453);

-- Ejercicio 10: Actualiza ahora los datos faltantes correspondientes al `CustomerName` 'La pegatina After'

UPDATE customers_mod
SET address_line1 = 'Poligono Industrial de Son Castelló',address_line2= 'Nave 92', city = 'Palma de mallorca', state = 'España',postal_code = 28123,country ='España', sales_rep_employee_number= 25, credit_limit= 5000000
WHERE customer_name = 'La pegatina After';