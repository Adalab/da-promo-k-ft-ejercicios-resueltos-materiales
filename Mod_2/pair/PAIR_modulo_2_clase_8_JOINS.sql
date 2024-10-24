-- PAIR Clase 9, modulo 2, JOINS

/* Nota: en estos ejercicios tenemos que poner en práctica todo lo aprendido hasta este momento.
 Además de tener que realizar uniones entre tablas, también tendrás que hacer agrupaciones de los datos
 y ordenarlos en base a alguna de sus columnas. Seguimos trabajando sobre la base de datos Northwind*/
 
 USE northwind;
 
 /* 
Pedidos por empresa en UK:
Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos con 
la que podamos conocer cuántos pedidos ha realizado cada empresa cliente de UK. Nos piden el ID del cliente y 
el nombre de la empresa y el número de pedidos.*/

SELECT Customers.CompanyName AS NombreEmpresa, Orders.CustomerID AS Identificador, COUNT(Orders.OrderID) AS NumOrders
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.Country = 'UK'
GROUP BY Orders.CustomerID, Customers.CompanyName;

/* 
Productos pedidos por empresa en UK por año:
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y han decidido pedirnos 
una serie de consultas adicionales. La primera de ellas consiste en una query que nos sirva para conocer cuántos objetos
 ha pedido cada empresa cliente de UK durante cada año. Nos piden concretamente conocer el nombre de la empresa, el año,
 y la cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.*/
 
SELECT Customers.CompanyName, YEAR(Orders.OrderDate) AS OrderYear,
    SUM(OrderDetails.Quantity) AS NumProducts,
    SUM(OrderDetails.Quantity * (OrderDetails.UnitPrice * (1 - OrderDetails.Discount))) AS TotalPrice
FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE Customers.Country = 'UK'
GROUP BY Customers.CompanyName, YEAR(Orders.OrderDate);

/*
BONUS: Pedidos que han realizado cada compañía y su fecha:
Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han obtenido, desde la central nos 
han pedido una consulta que indique el nombre de cada compañia cliente junto con cada pedido que han realizado y su fecha.
*/
SELECT Orders.OrderID, Customers.CompanyName, Orders.OrderDate
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;

/*
BONUS: Tipos de producto vendidos:
Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías, nombre de la categoría y el nombre 
del producto, y el total de dinero por el que se ha vendido cada tipo de producto (teniendo en cuenta los descuentos).
*/

SELECT 
	Products.CategoryID,
    Products.ProductName,
    Categories.CategoryName,
    SUM(OrderDetails.Quantity * OrderDetails.UnitPrice * (1 - OrderDetails.Discount)) AS TotalMoney
FROM 
    OrderDetails
INNER JOIN 
    Products ON OrderDetails.ProductID = Products.ProductID
INNER JOIN 
    Categories ON Products.CategoryID = Categories.CategoryID
GROUP BY 
    Products.ProductName, Products.CategoryID, Categories.CategoryName;
    
/*
Qué empresas tenemos en la BBDD Northwind:
Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre de todas las empresas cliente, los ID de sus pedidos y las fechas.
*/

SELECT Orders.OrderID,Customers.CompanyName,Orders.OrderDate
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;


/*
Pedidos por cliente de UK:
Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de pedidos que ha realizado cada cliente del propio Reino Unido de cara a 
conocerlos mejor y poder adaptarse al mercado actual. Especificamente nos piden el nombre de cada compañía cliente junto con el número de pedidos.
*/

SELECT Customers.CompanyName, COUNT(Orders.OrderID) AS NumOrders
FROM Customers
INNER JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.Country = 'UK'
GROUP BY Customers.CompanyName;


/*
Empresas de UK y sus pedidos:
También nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido (tengan pedidos o no) junto con los ID de todos los pedidos 
que han realizado y la fecha del pedido.
*/

SELECT Orders.OrderID, Customers.CompanyName,Orders.OrderDate
FROM Customers
LEFT JOIN Orders 
ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.Country = 'UK';


/*
Empleadas que sean de la misma ciudad:
Ejercicio de SELF JOIN: Desde recursos humanos nos piden realizar una consulta que muestre por pantalla los datos de todas las empleadas y sus supervisoras. 
Concretamente nos piden: la ubicación, nombre, y apellido tanto de las empleadas como de las jefas. Investiga el resultado, ¿sabes decir quién es el director?
*/

SELECT 
    e1.City AS City,
    e1.FirstName AS Nombre_empleado,
    e1.LastName AS Apellido_empleado,
    e2.City AS City,
    e2.FirstName AS NombreJefe,
    e2.LastName AS ApellidoJefe
FROM 
    employees e1
LEFT JOIN 
    employees e2 ON e1.ReportsTo = e2.EmployeeID;