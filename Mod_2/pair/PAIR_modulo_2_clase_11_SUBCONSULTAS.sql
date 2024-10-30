-- EJERCICIO CLASE 11, MODULO 2 SUBCONSULTAS

USE northwind;


/*
1-Extraed los pedidos con el máximo "order_date" para cada empleado.
Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. 
Para eso nos pide que lo hagamos con una query correlacionada.
*/

SELECT OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate
FROM orders AS O1
WHERE OrderDate =
				(SELECT MAX(OrderDate)
				FROM orders AS O2
				WHERE O2.EmployeeID = O1.EmployeeID);
   
   
/*
2- Extraed el precio unitario máximo (unit_price) de cada producto vendido.
Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario. 
De nuevo lo tendréis que hacer con queries correlacionadas.
*/

SELECT DISTINCT a.ProductID, a.UnitPrice AS Max_unit_price_sold
FROM orderdetails  AS a
WHERE a.UnitPrice = 
					(SELECT MAX(UnitPrice)
					FROM orderdetails AS b
					WHERE a.ProductID = b.ProductID)
ORDER BY a.ProductID;


/*
3- Extraed información de los productos "Beverages"

En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar 
un tipo de producto. En concreto, tienen especial interés por los productos con categoría "Beverages". 
Devuelve el ID del producto, el nombre del producto y su ID de categoría.
*/

SELECT ProductID, ProductName, CategoryID
FROM products
WHERE CategoryID IN (SELECT CategoryID
						FROM categories
						WHERE CategoryName = "Beverages");


/*
4- Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país

Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, entonces podría dirigirse 
a estos países para buscar proveedores adicionales.
*/

SELECT DISTINCT country
FROM customers
WHERE country NOT IN (SELECT DISTINCT country
                        FROM suppliers);

/*
5- Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread"

Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto 
"Grandma's Boysenberry Spread" (ProductID 6) en un solo pedido.
*/

SELECT o.OrderID, 
       o.CustomerID
FROM orders AS o
WHERE 
(
    SELECT Quantity 
    FROM orderdetails AS od
    WHERE o.OrderID = od.OrderID AND od.ProductID = 6
) > 20;

SELECT o.OrderID, 
       o.CustomerID
FROM orders AS o
WHERE 
(
    SELECT Quantity 
    FROM orderdetails AS od
    inner join products using(ProductID)
    WHERE o.OrderID = od.OrderID AND ProductName= "Grandma's Boysenberry Spread"
) > 20;


/*
6- Qué producto es más popular

Extraed cuál es el producto que más ha sido comprado y la cantidad que se compró.
*/

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
