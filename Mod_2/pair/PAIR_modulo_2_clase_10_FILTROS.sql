-- PAIR Clase 10, modulo 2, FILTROS

USE tienda;

/*
Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquelas compañias que están 
afincadas en ciudades que empiezan por "A" o "B". Necesita que le devolvamos la ciudad, el nombre de la 
compañia y el nombre de contacto.
*/

SELECT city, customer_name, contact_first_name
FROM customers
WHERE city LIKE 'A%' OR city LIKE 'B%';

/*
Número de pedidos que han hecho en las ciudades que empiezan con L.
En este caso, nuestro objetivo es devolver los mismos campos que en la query anterior el número de total
 de pedidos que han hecho todas las ciudades que empiezan por "L".
*/

SELECT c.city, c.customer_name AS 'Nombre de la empresa', c.contact_first_name AS 'Nombre de contacto', COUNT(o.order_number) AS 'Número de pedidos'
FROM customers c
JOIN orders o ON c.customer_number = o.customer_number
WHERE c.city LIKE 'L%'
GROUP BY c.city, c.customer_name, c.contact_first_name;


/*
Todos los clientes cuyo "country" no incluya "USA".
Nuestro objetivo es extraer los clientes que no sean de USA. Extraer el nombre de contacto, su pais y el nombre de la compañia.
*/

SELECT customer_name AS COMPANY, contact_first_name,contact_last_name,country
FROM customers
WHERE country NOT LIKE 'USA';

/*
Todos los clientes que no tengan una "A" en segunda posición en su nombre.
Devolved unicamente el nombre de contacto.
*/

SELECT ContactName
FROM northwind.customers
where ContactName NOT like "_A%"


/*
Extraer toda la información sobre las compañias que tengamos en la BBDD

Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los clientes y proveedores
 que tenemos en la BBDD. Mostrad la ciudad a la que pertenecen, el nombre de la empresa y el nombre del
 contacto, además de la relación (Proveedor o Cliente). Pero importante! No debe haber duplicados en 
 nuestra respuesta. La columna Relationship no existe y debe ser creada como columna temporal. Para ello
 añade el valor que le quieras dar al campo y utilizada como alias Relationship.

Nota: Deberás crear esta columna temporal en cada instrucción SELECT.
*/

