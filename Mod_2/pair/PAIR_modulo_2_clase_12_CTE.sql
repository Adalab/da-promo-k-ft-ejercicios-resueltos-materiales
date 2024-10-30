-- PAIR clase 12 modulo 2, CTEs

USE northwind;

-- 1. Extraer en una CTE todos los nombres de las compa�ias y los id de los compradores. 

WITH myCTE (CustID, CompanyName) AS
									(SELECT customer_id,company_name
									FROM customers)
SELECT CustID,CompanyName
FROM myCTE;

-- 2. Selecciona solo los de que vengan de "Germany" 

WITH myCTE2 (CustID, CompanyName, Country) AS
											(SELECT customer_id,company_name, country 
											FROM customers
											WHERE country = 'Germany')
SELECT CustID,CompanyName
FROM myCTE2;

-- 3. Extraed el id de las facturas y su fecha de cada cliente. 

WITH myCTE AS
			(SELECT c.customer_id,
					c.company_name,
					o.order_id,
					o.order_date
			FROM customers c
			INNER JOIN orders o 
			ON c.customer_id = o.customer_id)
   
   
SELECT customer_id,
       company_name,
       order_id,
       order_date
FROM myCTE
ORDER BY order_date ASC ;

-- 4. Contad el nUmero de facturas por cliente

WITH myCTE AS
  (SELECT c.customer_id,
          c.company_name,
          o.order_id,
          o.order_date
   FROM customers c
   INNER JOIN orders o ON c.customer_id = o.customer_id)
SELECT customer_id,
       company_name, 
       count(order_id)
FROM myCTE
GROUP BY customer_id;

/* 5. Cuál la cantidad media pedida de todos los productos ProductID.
Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media*/

WITH total_productos
AS (
	SELECT product_id, SUM(quantity) AS pedidos_company_cantidad
	FROM order_details
    GROUP BY product_id)
SELECT AVG (pedidos_company_cantidad) AS cantidad_media
FROM total_productos;


/* 6. Necesitamos saber el nombre de la categoría, su precio medio, máximo y mínimo.
*/


WITH tabla AS(SELECT c.*, p.unit_price FROM products AS p 
INNER JOIN categories AS c
ON p.category_id = c.category_id)
SELECT category_name, round(AVG(unit_price),2) AS media, max(unit_price) AS max, min(unit_price) AS min
FROM tabla
GROUP BY category_name ;

/* 6. La empresa nos ha pedido que busquemos el nombre de cliente, 
su teléfono y el número de pedidos que ha hecho cada uno de ellos
*/

WITH tabla AS (SELECT * FROM orders AS o
NATURAL JOIN customers AS c)
SELECT count(*), contact_name, phone, YEAR(order_date)
FROM tabla
GROUP BY contact_name, phone, YEAR(order_date);

SELECT count(*), contact_name, phone
FROM (WITH tabla AS (SELECT * FROM orders AS o
NATURAL JOIN customers AS c)
SELECT *
FROM tabla) AS tabla2
GROUP BY contact_name, phone;

SELECT
    COUNT(*) AS count_per_contact,
    c.contact_name,
    c.phone
FROM
    orders AS o
JOIN
    customers AS c ON o.customer_id = c.customer_id
GROUP BY
    c.contact_name,
    c.phone;

/*7. Modifica la cte del ejercicio anterior, úsala en una subconsulta para saber el nombre 
del cliente y su teléfono, para aquellos clientes que hayan hecho más de 6 pedidos en
el año 1998
*/

SELECT contact_name, phone
FROM customers
WHERE contact_name IN (
						WITH tabla AS 
										(SELECT * FROM orders AS o
										NATURAL JOIN customers AS c
										WHERE YEAR(order_date) = 1998)


SELECT contact_name
FROM tabla
GROUP BY contact_name
HAVING count(contact_name)>6);

/* 8.Modifica la consulta anterior para obtener los mismos resultados pero con los pedidos por año que ha hecho cada cliente.
*/

WITH tabla AS 
			(SELECT count(*) AS num_suppliers, country
			FROM suppliers
			GROUP BY country)

SELECT t.*,  e.first_name, e.last_name, e.city
FROM tabla AS t
INNER JOIN employees AS e
ON t.country = e.country;

/* 9. Modifica la cte del ejercicio anterior, úsala en una subconsulta para saber el nombre del cliente y su teléfono, 
para aquellos clientes que hayan hecho más de 6 pedidos en el año 1998
*/

WITH tabla AS
			(SELECT order_id, (unit_price*quantity)*(1-discount) AS total
			FROM northwind.order_details)

SELECT tabla.order_id, round(sum(total),2) AS total, o.customer_id
FROM tabla 
INNER JOIN orders AS o
ON o.order_id=tabla.order_id
GROUP BY order_id
ORDER BY total DESC;