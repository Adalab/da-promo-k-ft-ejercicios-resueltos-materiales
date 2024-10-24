-- Funciones de agregación:

	-- Resumen de unos datos. Ej. suma de precios --> nos devuelve 1 dato.
    -- MIN() devuelve el mínimo de una columna
		SELECT MIN(col)
			FROM tabla;
	-- MAX() devuelve el máximo de una columna
		SELECT MAX(col)
			FROM tabla;
    -- SUM() devuelve la suma de los valores de una columna
		SELECT SUM(col)
			FROM tabla;
	-- AVG() devuelve el máximo de una columna
		SELECT MAX(col)
			FROM tabla;
            
-- GROUP BY: agrupa filas en función de los valores de una o varias columnas.
				-- OJO: necesitamos usar funciones de agregación en el SELECT para poder obtener el output
        SELECT columna_agrupada, función_agregación(columna_calculo)
			FROM tabla
			GROUP BY columna_agrupada;
            
		-- ejemplo:
        
        SELECT product_line as grupo, AVG(buy_price), MIN(buy_price), MAX(buy_price)
			FROM products
			GROUP BY grupo;
            
        /* estamos agrupando por product_line (en este caso con alias)
        tenemos que usar funciones de agregación en el SELECT --> tantas cómo queramos, 
        para misma columna o varias */
        
        -- USO DEL WHERE EN SELECT en GROUP BY:
        -- podemos usar WHERE al hacer GROUP BY para filtrar los datos que queremos agrupar:
        
        SELECT product_line, AVG(buy_price)
			FROM products
			WHERE product_line IN ("Motorcycles", "Classic Cars")
			GROUP BY product_line;

		/* En este ejemplo, antes de agrupar los datos hemos filtrado por dos categorías,
        el grupo se hace sobre los datos filtrados previamente (no vamos a tener ninguna fila que
        no cumpla con las condiciones del WHERE */

		/* HAVING: filtro para las características de los grupos después del GROUP BY.
        Podemos enterlo cómo el WHERE de lo devuelve el GROUP BY. Si podemos incluirlo en el
        SELECT del GROUP BY, podemos usarlo en el HAVING. */

    
		SELECT product_line as grupo, AVG(buy_price), MIN(buy_price), MAX(buy_price)
			FROM products
			GROUP BY grupo
			HAVING AVG(buy_price) > 50;
    
-- Ejemplos completos  
   
SELECT product_line, AVG(buy_price), AVG(quantity_in_stock)
	FROM products
	WHERE product_line IN ("Motorcycles", "Classic Cars")
    GROUP BY product_line
    HAVING AVG(quantity_in_stock) > 5400;
    
SELECT product_line, COUNT(*), AVG(buy_price)
	FROM products
    WHERE  buy_price > 50
    GROUP BY product_line
    HAVING COUNT(*) > 10;
    
 
-- EJERCICIO modulo-2-leccion-08-consultas-avanzadas

/*
vamos a usar una tabla ya creada llamada customers (clientes/as), que está en la base de datos tienda.
*/


 USE tienda;
 
-- Ejercicio 1: Obtener el número identificativo de cliente más bajo de la base de datos.
SELECT MIN(customer_number) AS numero_cliente_minimo
FROM customers;

-- Ejercicio 2: Seleccionar el límite de crédito medio para los clientes de España.
SELECT AVG(credit_limit) AS limite_credito_medio_espana
FROM customers
WHERE country = 'Spain';

-- Ejercicio 3: Seleccionar el número de clientes en Francia.
SELECT COUNT(*) AS numero_clientes_francia
FROM customers
WHERE country = 'France';

-- Ejercicio 4: Seleccionar el máximo de crédito que tiene cualquiera de los clientes del empleado con número 1323.
SELECT MAX(credit_limit) AS max_cred
FROM customers
WHERE sales_rep_employee_number = 1323;

-- Ejercicio 5: ¿Cuál es el número máximo de empleado de la tabla customers?
SELECT MAX(sales_rep_employee_number) AS maximo_numero_empleado
FROM customers;

-- Ejercicio 6: Seleccionar el número de cada empleado de ventas, así como el número de clientes distintos que tiene cada uno.
SELECT sales_rep_employee_number, COUNT(DISTINCT customer_number) AS clientes_distintos
FROM customers
GROUP BY sales_rep_employee_number;

-- Ejercicio 7: Seleccionar el número de cada empleado de ventas que tenga más de 7 clientes distintos.
SELECT sales_rep_employee_number, COUNT(DISTINCT customer_number) AS clientes_distintos
FROM customers
GROUP BY sales_rep_employee_number
HAVING clientes_distintos > 7;

-- Ejercicio 8: Seleccionar el número de cada empleado de ventas, así como el número de clientes distintos que tiene cada uno.
-- Asignar una etiqueta de "AltoRendimiento" a aquellos empleados con más de 7 clientes distintos.
SELECT sales_rep_employee_number,COUNT(DISTINCT customer_number) AS clientes_distintos,
       CASE 
		WHEN COUNT(DISTINCT customer_number) > 7 THEN 'AltoRendimiento' 
        ELSE NULL 
        END AS rendimiento
FROM customers
GROUP BY sales_rep_employee_number;

-- Ejercicio 9: Seleccionar el número de clientes en cada país.
SELECT country, COUNT(*) AS numero_clientes
FROM customers
GROUP BY country;

-- Ejercicio 10: Seleccionar aquellos países que tienen clientes de más de 3 ciudades diferentes.
SELECT country
FROM customers
GROUP BY country
HAVING COUNT(DISTINCT city) > 3;  
    
	
