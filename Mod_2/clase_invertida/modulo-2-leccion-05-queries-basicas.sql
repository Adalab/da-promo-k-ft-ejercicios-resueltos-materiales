-- Queries básicas

-- Select --> es el output (columnas) que queremos recibir

SELECT col1, col2, col3 
	FROM tabla;
    
	-- con * seleccionamos todas las columnas
    
-- WHERE: --> condición o condiciones:

SELECT col1, col2, col3 
	FROM tabla
    WHERE col6 = condidicion; -- podemos usar cualquier columna de nuestra tabla
    
    -- Podemos usar varias columnas:
		-- OR --> se tiene que cumplir una de las condiciones:
        SELECT * 
			FROM products
            WHERE product_line = "Classic Cars"
				OR product_line = "Motorcycles";
		
        -- AND --> se tienen ls dos condiciones. IMPORTANTE la lógica de la comparación
		SELECT * 
			FROM products
            WHERE product_line = "Classic Cars"
				AND product_line = "Motorcycles"; -- no devuelve nada porque la comparación no tiene sentido
			
		SELECT * 
			FROM products
            WHERE product_line = "Classic Cars"
				AND buy_price > 50;
                
		-- Anidados:
        SELECT * 
			FROM products
            WHERE (product_line = "Classic Cars"
				AND buy_price > 50)
                OR (product_line = "Motorcycles"
                AND buy_price > 30);
                
-- IS NULL --> buscamos valores nulos

-- NOT NULL --> valores no nulos

-- ORDER BY --> ordena los valores en base a una columna:
	SELECT *
		FROM products	
        ORDER BY buy_price;
				-- por defecto es ascendente
	SELECT *
		FROM products	
        ORDER BY buy_price DESC;
        
-- DISTINCT --> Valores únicos
	SELECT DISTINCT product_line
		FROM products;
        
-- IN 
		SELECT * 
			FROM products
            WHERE product_line = "Classic Cars"
				OR product_line = "Motorcycles";
                
		SELECT * 
			FROM products
            WHERE product_line IN ("Classic Cars", "Motorcycles");
            
-- AS --> alias para nuestras columnas:
		
        SELECT product_code AS codigo
			FROM products
            WHERE codigo = "S10_1949"; -- esto da error porque la columna no existe en ese orden de ejecución
            
		SELECT product_code AS codigo
			FROM products
            WHERE product_code = "S10_1949";
            
-- -- /* ----ORDEN DE EJECUCION DE LAS CONSULTAS----- */ -- --
FROM
JOIN
WHERE
GROUP BY
HAVING
SELECT
DISTINCT
ORDER BY
OFFSET
LIMIT

-- Limit --> limita el resultado de la consulta

	SELECT *
		FROM products
        LIMIT 5;
        
-- OFFSET -->

	SELECT *
		FROM products
        LIMIT 5
        OFFSET 2;
        
	SELECT *
		FROM products
        OFFSET 5
        LIMIT 10; -- el orden importa!!
        
-- QUERY EJEMPLO COMPLETO:

SELECT product_name AS nombre, product_line AS cat, quantity_in_stock AS cant, 
		buy_price AS price, (quantity_in_stock * buy_price) as valor
        FROM products
        WHERE product_line IN ("Classic Cars", "Motorcycles")
        ORDER BY product_name
        LIMIT 15
        OFFSET 3;
        
SELECT product_name AS nombre, product_line AS cat, quantity_in_stock AS cant, 
		buy_price AS price, (quantity_in_stock * buy_price) as valor
        FROM products
        WHERE product_line IN ("Classic Cars", "Motorcycles")
			  AND buy_price BETWEEN 50 AND 100
        ORDER BY nombre -- aquí sí existe el alias
        LIMIT 15
        OFFSET 3;

-- EJERCICIOS modulo-2-leccion-07-consultas-basicas

USE tienda;
 
## Ejercicio 1: 
/* Realiza una consulta `SELECT` que obtenga los nombres, telefonos y direcciones de todas las empresas cliente de la tabla `customers`.*/

SELECT * FROM customers;
SELECT customer_name, phone, address_line1     
FROM customers; 

## Ejercicio 2:
/*Realiza una consulta que obtenga los telefonos y direcciones de aquellas empresas de la tabla `customers` que se encuentren en USA (es su pais).*/

SELECT customer_name,phone, address_line1, country FROM customers
WHERE country = "USA"; 

## Ejercicio 3:
/* Realiza una consulta que obtenga los nombres y apellidos de las personas de contacto en cada empresa que no tenga segunda linea de direccion.*/

SELECT contact_first_name, contact_last_name FROM customers
WHERE address_line2 IS NULL; 

## Ejercicio 4:
/* Busca aquellos registros de la tabla `customers` que tengan un valor guardado para el campo *state*. 
Este atributo solo es valido para ciertos paises por lo que habra varias entradas con valor `NULL`.*/

SELECT * FROM customers
WHERE state IS NOT NULL;

## Ejercicio 5:
/* Busca aquellos registros de la tabla `customers` que correspondan a clientes de USA pero que no tengan un valor guardado para el campo *state*.*/

SELECT * FROM customers
WHERE country = "USA" AND state IS NULL;

## Ejercicio 6:
/* Selecciona el pais (`country`) correspondiente a los registros de clientes con un limite de credito (`credit_limit`) mayor que $10000.*/

SELECT DISTINCT country FROM customers
WHERE credit_limit > 10000; 