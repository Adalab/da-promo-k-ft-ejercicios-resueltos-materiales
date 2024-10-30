-- UNION --> combina el resultado de dos queries, descartada duplicados

-- OJO: ambos SELECCT tienen que devolver el mismo número de columnas
-- Si queremos incluir un alias, debe ir en el primer SELECT

SELECT contact_first_name AS nombre, contact_last_name AS apellido 
	FROM customers
UNION
SELECT first_name , last_name
	FROM employees;
    
-- UNION ALL --> combina el resultado de dos queries, incluye duplicados (nos devielve valores únicos)

-- OJO: ambos SELECCT tienen que devolver el mismo número de columnas
-- Si queremos incluir un alias, debe ir en el primer SELECT

SELECT country
	FROM customers
UNION ALL
SELECT country
	FROM offices;
    
-- IN --> es una condición que va con el WHERE, filtra por una lista de valores

SELECT col1, col2, col3
	FROM tabla
    WHERE col4 in (val1,val2);
	
-- LIKE --> nos permite filtrar por patrones de strings (NO de regex)

	/*  % cero o más caracteres:
			A% empieza por
            %a termina por
            %a% que contenga la letra
		_ representa 1 caracter (cualquiera)
			e_ empieza por e y tiene 2 letras
            e_% empieza por e y tiene al menos 2 letras

    
/*
EJERCICIO 1:
Selecciona los apellidos que se encuentren en ambas tablas para employees y customers, con alias 'Apellidos':
*/

SELECT contact_last_name
	FROM customers   -- devueve 122 filas
UNION
SELECT last_name
	FROM employees;   -- devuelve 23 filas
    
    -- contar apellidos distintos:
    SELECT COUNT(DISTINCT contact_last_name)
	FROM customers;  -- tenemos 108 apellidos diferentes
    
/*
EJERCICIO 2:
Selecciona los nombres con alias 'nombre' y apellidos, con alias 'Apellidos' tanto de los clientes como de los 
empleados de las tablas employees y customers:
*/

SELECT contact_first_name AS nombre, contact_last_name AS apellido 
	FROM customers
UNION
SELECT first_name , last_name
	FROM employees;
    
/*
EJERCICIO 3:
Selecciona todos los nombres con alias 'nombre' y apellidos, con alias 'Apellidos' tanto de los clientes como de 
los empleados de las tablas employees y customers:
*/

SELECT contact_first_name AS nombre, contact_last_name AS apellido 
	FROM customers
UNION ALL
SELECT first_name , last_name
	FROM employees;
    
/*
EJERCICIO 4:
Queremos ver ahora el employee_number como 'Número empleado', first_name como 'nombre Empleado' y last_name como 
'Apellido Empleado' para los empleados con employee_number: 1002,1076,1088 y 1612:
*/

SELECT employee_number AS num_emp, first_name AS nombre, last_name AS apellido
	FROM employees
    WHERE employee_number IN (1002,1076,1088, 1612);
    
/*
EJERCICIO 5:
Queremos ver ahora la 'ciudad' y los nombres de las empresas como 'nombre de la empresa ' de la tabla customers, que 
no estén en: Ireland, France, Germany:
*/

SELECT city AS ciudad, customer_name AS nombre
	FROM customers 
    WHERE city NOT IN ("Ireland", "France", "Germany");
    
/*
EJERCICIO 6:
Encuentra los campos nombre del cliente y ciudad, de aquellas ciudades de la tabla de customers que terminen en 'on':
*/

SELECT customer_name, city
	FROM customers
    WHERE city LIKE '%on';
    
/*
EJERCICIO 7:
Encuentra los campos nombre del cliente, ciudad de aquellas ciudades de la tabla de customers que terminen en 'on' 
y que unicamente sean de longitud 4:
*/

SELECT customer_name, city
	FROM customers
    WHERE city LIKE '__on'; 
    
SELECT customer_name, city
	FROM customers
    WHERE (city LIKE '%on' AND city LIKE '____');
    
SELECT customer_name, city
	FROM customers
    WHERE city LIKE '%on' AND CHAR_LENGHT(city) = 4;
    
/*
EJERCICIO 8:
Encuentra el nombre del cliente, primera dirección y ciudad de aquellas ciudades que contengan el número 3 en su 
dirección (o lo que es lo mismo, su primera dirección):
*/

SELECT customer_name, address_line1, city
	FROM customers
    WHERE address_line1 LIKE '%3%';
    
/*
EJERCICIO 9:
Encuentra el nombre del cliente, primera dirección y ciudad de aquellas ciudades que contengan el número 3 en su
 dirección postal y la ciudad NO empiece por T:
*/

SELECT customer_name, address_line1, city
	FROM customers
    WHERE address_line1 LIKE '%3%' AND city NOT LIKE 'T%'; 
    
/*
EJERCICIO 10:
Selecciona, haciendo uso de expresiones regulares, los campos nombre del cliente, primera dirección y ciudad. 
Unicamente en el caso que la dirección postal, posea algún número en dicho campo:
*/

SELECT customer_name, address_line1, city
	FROM customers
    WHERE address_line1 REGEXP '[0-9]';
    
SELECT customer_name, address_line1, city
	FROM customers
    WHERE address_line1 REGEXP '\d';
 
 
 
-- CASE:
 
SELECT * 
	FROM products;
    
SELECT product_name, product_line, buy_price,
		CASE
			WHEN buy_price > 100 THEN "precio alto"
            ELSE "precio bajo"
            END AS etiqueta
	FROM products;
    
SELECT product_name, product_line, buy_price
	FROM products
    WHERE buy_price > (SELECT 
							CASE 
                            WHEN product_line = "Motorcycles" THEN 50
                            WHEN product_line = "Classic Cars" THEN 80
                            ELSE 100
                            END);
						