-- SUBCONSULTAS:

-- Utilizamos el valor de una consulta "secundaria" para filtrar nuestra consulta principal.
-- OJO: el valor o valores tiene que tener que ver con la condición
SELECT AVG(buy_price)
	FROM products; --  54.39
    
SELECT * 	
	FROM products
	WHERE buy_price > 54.39;
    
SELECT * 	
	FROM products
	WHERE buy_price > (SELECT AVG(buy_price)
							FROM products);
    
/*EJERCICIO 1:
Calcula el numero de clientes por cada ciudad.
*/

SELECT COUNT(customer_number) AS num_clientes, city
	FROM customers
    GROUP BY city;

-- En esta subquery tengo todas las ciudades:
SELECT DISTINCT city 
FROM customers;


-- En la consulta principal, seleccionaremos la ciudad y contaremos los clientes en esa ciudad
-- usando la subconsulta para filtrar por las ciudades.
SELECT city, 
 (SELECT COUNT(customer_number)
 FROM customers AS c2
 WHERE c2.city = c1.city) AS numero_clientes
FROM (SELECT DISTINCT city FROM customers) AS c1;


/*EJERCICIO 2:
Usando la consulta anterior como subconsulta, selecciona la ciudad con el mayor numero de clientes.
*/
SELECT COUNT(customer_number) AS num_clientes, city
	FROM customers
    GROUP BY city;

SELECT COUNT(customer_number), city
    FROM customers
    GROUP BY city
    HAVING COUNT(customer_number) >= ALL (
        SELECT COUNT(customer_number)
        FROM customers
        GROUP BY city
        );
        
SELECT COUNT(customer_number) AS customer_count, city
FROM customers
GROUP BY city
HAVING COUNT(customer_number) >= (
    SELECT MAX(customer_count)
    FROM (
        SELECT COUNT(customer_number) AS customer_count
        FROM customers
        GROUP BY city
    ) AS max_counts
);


/*EJERCICIO 3:
Por último, usa todas las consultas anteriores para seleccionar el customerNumber, nombre y apellido
 de las clientas asignadas a la ciudad con mayor numero de clientas.
*/
SELECT COUNT(customer_number), city
    FROM customers
    GROUP BY city
    HAVING COUNT(customer_number) >= ALL (
        SELECT COUNT(customer_number)
        FROM customers
        GROUP BY city
        );

SELECT *
	FROM customers
    WHERE city IN ("Madrid", "NYC");

SELECT *
	FROM customers
    WHERE city IN (SELECT city
    FROM customers
    GROUP BY city
    HAVING COUNT(customer_number) >= ALL (
        SELECT COUNT(customer_number)
        FROM customers
        GROUP BY city
        ));
        
/*EJERCICIO 4:
Queremos ver ahora que empleados tienen algún contrato asignado con alguno de los clientes existentes.
 Para ello selecciona employeeNumber como 'Número empleado', firstName como 'nombre Empleado' y lastName como 'Apellido Empleado'
*/


SELECT  employee_number AS 'Número empleado', first_name AS 'Nombre Empleado' , last_name AS 'Apellido Empleado'
FROM employees
WHERE employee_number IN (
SELECT sales_rep_employee_number 
FROM customers);        
/*EJERCICIO 5:
Queremos ver ahora en cuantas ciudades en las cuales tenemos clientes, no también una oficina de nuestra empresa para ello:
 Selecciona aquellas ciudades como 'ciudad' y los nombres de las empresas como 'nombre de la empresa ' de la tabla customers,
 sin repeticiones, que no tengan una oficina en dicha ciudad de la tabla offices.
 */

-- primero vemos que hay en la tabla offices
SELECT * 
FROM offices AS o 
LIMIT 10;


-- Luego selecionamos todas las distintas ciudades donde hay oficina
SELECT DISTINCT city
FROM offices AS o;


-- Ahora hacemos la query principal usando la subquery anterior para excluir las ciudades que tienen oficina
SELECT DISTINCT city AS ciudad, customer_name AS nombre_de_la_empresa
FROM customers AS c
WHERE city NOT IN (
 SELECT DISTINCT city
 FROM offices AS o);
 
 -- Subqueries correlacionadas:
 
 SELECT *
	FROM PRODUCTS;
    
SELECT AVG(buy_price), product_line	
	FROM products
    GROUP BY product_line;

SELECT * 
	FROM products
    WHERE product_line = "Motorcycles" AND buy_price > 50.6;
    
SELECT AVG(buy_price) 
	FROM products
    WHERE product_line = "Motorcycles";
    
SELECT *
	FROM products AS a1
    WHERE buy_price > (SELECT AVG(buy_price) 
	FROM products AS a2
    WHERE a2.product_line = a1.product_line);
    


with jefas as (select employee_number as j_number, first_name as j_first, last_name as j_last
					from employees)
select employee_number as emp_number, first_name as emp_first, last_name as emp_last, reports_to, j.*
	from employees as e
    left join jefas as j
    on j.j_number = e.reports_to;