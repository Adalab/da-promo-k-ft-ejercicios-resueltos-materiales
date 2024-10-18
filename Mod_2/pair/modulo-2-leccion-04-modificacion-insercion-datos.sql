p.modulo-2-leccion-06-modificacion-insercion-datos


1. En este ejercicio vamos a corregir los errores que hemos encontrado en nuestras tablas.

-- Cambios en la tabla zapatillas

ALTER table zapatillas
add column `Marca` varchar(45);

ALTER table zapatillas
add column Talla int; 

-- Cambios en la tabla empleados
ALTER TABLE empleados MODIFY COLUMN salario FLOAT;

-- Cambios en la tabla clientes

ALTER TABLE clientes DROP COLUMN Pais;

ALTER TABLE clientes MODIFY COLUMN Código_Postal int;
ALTER table clientes
add column `Total` decimal(6,0);

2. Lo primero que vamos a hacer es insertar datos en nuestra BBDD con los siguientes datos:

INSERT INTO zapatillas (Modelo, Color, Marca, Talla)
VALUES ("XQYUN", "Negro", "Nike", 42),
		("pQYUN", "Rosa", "Nike", 39)
		("OPNYT","Verdes","Adidas",35) ;

 -- inserccion tabla empleados
 
INSERT INTO empleados (Nombre, Tienda, salario, Fecha_incorporacion)
VALUES ("Laura", "Alcobendas", 25987, '2010-09-03'),
("Maria","Sevilla",NULL,'2001-04-11'),("Ester","Oviedo",30165.98,'29/11/2000');

 -- inserccion tabla clientes
 
INSERT INTO clientes (Nombre, Numero_Telf, Email, Direccion, Ciudad, Provincia, Código_Postal)
VALUES ("Monica", 1234567289, "monica@email.com", "Calle Felicidad", "Mostoles", "Madrid", 28176),
("Lorena",289345678,"lorena@email.com","Calle Alegria","Barcelona","Barcelona",12346),
("Carmen",298463759,"carmen@email.com","Calle del Color","Vigo","Pontevedra",23456)



 -- inserccion tabla factura
 
INSERT INTO factura (Numero_Factura, Fecha, idZapatillas, idEmpleado, idCliente, Total)
VALUES (123, "2001-11-12", 1,2,1, 54.98),
(1234,'2005-05-23',1,1,3,89.91),
(12345,'2015-09-18',2,3,3,76.23);


3. De nuevo nos hemos dado cuenta que hay algunos errores en la inserción de datos. En este ejercicios los actualizaremos para que nuestra BBDD este perfectita.

UPDATE zapatillas 
SET Color = "amarillas"
where Color = "Rosa";


UPDATE empleados 
SET Tienda = "A Coruña"
where Nombre = "Laura";


UPDATE clientes 
SET Numero_telf	 = 123456728
where Nombre = "Monica";


UPDATE factura 
SET Total = 89.91
where idZapatillas =2;