WITH prod AS(SELECT product_code, product_name, product_line, buy_price
				FROM products)
                
SELECT *
	FROM prod;
    
SELECT *
	FROM prod;
    
-- necesitamos obtener los productos y el precio medio por categoría de cada uno de ellos:

SELECT product_name,product_line, buy_price
	FROM products;
    
SELECT product_line, ROUND(AVG(buy_price), 2) as media
	FROM products
    GROUP BY product_line;
    
SELECT product_name,p.product_line, buy_price, media
	FROM products as p
    INNER JOIN (SELECT product_line, ROUND(AVG(buy_price), 2) as media
					FROM products
					GROUP BY product_line) as tabla
    USING (product_line);
    
WITH media_cat AS (SELECT product_line, ROUND(AVG(buy_price), 2) as media
						FROM products
						GROUP BY product_line)
                        
SELECT product_name,p.product_line, buy_price, media
	FROM products as p
    INNER JOIN media_cat
    USING (product_line);
    
/*EJERCICIO 3:
Por último, usa todas las consultas anteriores para seleccionar el customerNumber, nombre y apellido
 de las clientas asignadas a la ciudad con mayor numero de clientas.
*/

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

/*EJERCICIO 3:
Por último, usa todas las consultas anteriores para seleccionar el customerNumber, nombre y apellido
 de las clientas asignadas a la ciudad con mayor numero de clientas.
*/

WITH ciudad AS(SELECT COUNT(customer_number) AS num_clientes, city
        FROM customers
        GROUP BY city)

SELECT customer_name, contact_first_name, city -- 3º el output
	FROM customers
	WHERE city IN (SELECT city -- 2º las ciudades con max clientes
						FROM ciudad
						WHERE num_clientes = (SELECT MAX(num_clientes)
												FROM ciudad));  -- 1º necesitamos saber el num de clientes
        

/* 6- Qué producto es más popular

Extraed cuál es el producto que más ha sido comprado y la cantidad que se compró.
*/

-- Paso 1:
SELECT * 
	FROM products;
    
-- Paso 2: explorar dónde están los datos que necesitamos
SELECT *
	FROM order_details;
    
-- Paso 3: creo la tabla que necesito para obtener el resultado

SELECT *
	FROM products AS o
    INNER JOIN order_details AS p
    USING (product_id); 

-- Paso 4: veo que tengo que agrupar por producto

SELECT SUM(quantity), product_name
	FROM products AS o
    INNER JOIN order_details AS p
    USING (product_id)
    GROUP BY product_id;
    
-- Paso 5: crear el filtro

SELECT SUM(quantity) AS total, product_name
	FROM products AS o
    INNER JOIN order_details AS p
    USING (product_id)
    GROUP BY product_id
    HAVING total = 1577;
    
-- Paso 6: buscar cómo obtener la cantidad máxima:
WITH maximo AS (SELECT SUM(quantity) AS total, product_name
	FROM products AS o
    INNER JOIN order_details AS p
    USING (product_id)
    GROUP BY product_id)
    
SELECT MAX(total)
	FROM maximo;
    
-- Paso 7: juntamos las dos partes para obtener el resultado final:
WITH maximo AS (SELECT SUM(quantity) AS total, product_name
					FROM products AS o
					INNER JOIN order_details AS p
					USING (product_id)
					GROUP BY product_id)
    
SELECT SUM(quantity) AS total, product_name
	FROM products AS o
    INNER JOIN order_details AS p
    USING (product_id)
    GROUP BY product_id
    HAVING total = (SELECT MAX(total)
	FROM maximo);


-- Paso 8: me doy cuanta de que estaba usando TODA la CTE en el SELECT principal
WITH maximo AS (SELECT SUM(quantity) AS total, product_name
					FROM products AS o
					INNER JOIN order_details AS p
					USING (product_id)
					GROUP BY product_id)
    
SELECT *
	FROM maximo
    HAVING total = (SELECT MAX(total)
	FROM maximo);

-- opción con suvconsulta:

SELECT SUM(Quantity) AS Cantidad, ProductName
FROM orderdetails
INNER JOIN products
ON orderdetails.ProductID = products.ProductID
GROUP BY ProductName
HAVING Cantidad = (
	SELECT MAX(Cantidad)
	FROM 
		(SELECT ProductID, SUM(Quantity) AS Cantidad
		FROM orderdetails
		GROUP BY ProductID) AS t);