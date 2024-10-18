--EJERCICIOS modulo-2-leccion-05-creacion-tablas

/* Ejercicio 1: Crea la tabla Empleadas. De momento no te preocupes 
por definir restricciones a los datos que se pueden introducir, o por 
definir claves primarias o foráneas. Puedes ver a continuación un 
ejemplo de la tabla:*/

CREATE SCHEMA ejercicios_2;
USE ejercicios_2;


CREATE TABLE empleadas (
IDEmpleada INT,
Salario FLOAT,
Nombre VARCHAR(30),
Apellido VARCHAR(30),
Pais VARCHAR(10)
);

/*Ejercicio 2: Modifica la siguiente tabla, pero añadiendo una restricción 
de tabla que comprueba si la edad de la persona es mayor de 16 años. 
Llámala Personas2:

CREATE TABLE personas (
    id INT NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    nombre VARCHAR(255),
    edad INT,
    ciudad varchar(255) DEFAULT 'Madrid'
);

*/

CREATE TABLE Personas2(
ID INT NOT NULL,
Apellido VARCHAR(255) NOT NULL,
Nombre VARCHAR(255),
Edad INT,
Ciudad varchar(255) DEFAULT 'Madrid', -- incluimos una restricción de columna con un valor por defecto
CONSTRAINT CHK_Persona -- creamos una restricción para que la edad sea mayor o igual que 16
	CHECK (Edad>=16)
);

/*Ejercicio 3: Crea las tabla Empleadas y empleadas_en_proyectos, definiendo 
claves primarias, claves foránea, tipos de datos, etc. Haz que cuando se elimine
 una Empleada, se eliminen todas las entradas en empleadas_en_proyectos asociadas.
*/

CREATE TABLE Empleadas
(IDEmpleada INT NOT NULL AUTO_INCREMENT,
Salario FLOAT DEFAULT NULL,
Nombre VARCHAR(30) DEFAULT NULL,
Apellido VARCHAR(30) DEFAULT NULL,
Pais VARCHAR(10) DEFAULT NULL,
PRIMARY KEY (IDEmpleada) -- definimos la PRIMARY KEY de nuestra tabla
);


CREATE TABLE EmpleadasEnProyectos
(IDEmpleada INT NOT NULL,
IDProyecto INT NOT NULL,
PRIMARY KEY (IDEmpleada,IDProyecto), -- PRIMARY KEY compuesta, es una única PK formada por los datos de ambas columnas
CONSTRAINT fk_empleadas -- alias de nuestra restricción
	FOREIGN KEY (IDEmpleada) -- definimos la FK (columna que está en nuestra tabla y tiene que existir en la tabla madre)
	REFERENCES Empleadas (IDEmpleada) -- referencimos la FK --> dónde apunta la columna de nuestra tabla a la tabla madre
    ON DELETE CASCADE -- restricción para el borrado de registros de la tabla madre, si se eliminan filas que están relacionadas, también se borraran de esta tabla
);

/*Ejercicio 4: Crea la tabla customers (sin tener en cuenta claves foráneas relacionadas con la tabla Employees).*/

CREATE SCHEMA creacion_tienda;
USE creacion_tienda;

CREATE TABLE customers (
customerNumber int NOT NULL,
customerName varchar(50) NOT NULL,
contactLastName varchar(50) NOT NULL,
contactFirstName varchar(50) NOT NULL,
phone varchar(50) NOT NULL,
addressLine1 varchar(50) NOT NULL,
addressLine2 varchar(50) DEFAULT NULL,
city varchar(50) NOT NULL,
state varchar(50) DEFAULT NULL,
postalCode varchar(15) DEFAULT NULL,
country varchar(50) NOT NULL,
salesRepEmployeeNumber int DEFAULT NULL,
creditLimit decimal(10,2) DEFAULT NULL,
PRIMARY KEY (customerNumber) );

/*Ejercicio 5: Crea la tabla employees (sin tener en cuenta claves foráneas relacionadas con la tabla Customers).*/

CREATE TABLE employees (
employeeNumber int NOT NULL,
lastName varchar(50) NOT NULL,
firstName varchar(50) NOT NULL,
extension varchar(10) NOT NULL,
email varchar(100) NOT NULL,
officeCode varchar(10) NOT NULL,
reportsTo int DEFAULT NULL,
jobTitle varchar(50) NOT NULL,
PRIMARY KEY (employeeNumber)
);

/*Ejercicio 6: Crea de nuevo las dos tablas( con un nombre diferente a las dos creadas anteriormente)
 teniendo en cuenta las claves foráneas y restricciones para los datos (por ejemplo que el límite de 
 crédito nunca sea negativo... Todo lo que se te ocurra).
*/

CREATE TABLE employees1 (
employeeNumber int NOT NULL,
lastName varchar(50) NOT NULL,
firstName varchar(50) NOT NULL,
extension varchar(10) NOT NULL,
email varchar(100) NOT NULL,
officeCode varchar(10) NOT NULL,
reportsTo int DEFAULT NULL,
jobTitle varchar(50) NOT NULL,
PRIMARY KEY (employeeNumber) -- definimos la PK
);


CREATE TABLE customers2 (
customerNumber int NOT NULL,
customerName varchar(50) NOT NULL,
contactLastName varchar(50) NOT NULL,
contactFirstName varchar(50) NOT NULL,
phone varchar(50) NOT NULL,
addressLine1 varchar(50) NOT NULL,
addressLine2 varchar(50) DEFAULT NULL,
city varchar(50) NOT NULL,
state varchar(50) DEFAULT NULL,
postalCode varchar(15) DEFAULT NULL,
country varchar(50) NOT NULL,
salesRepEmployeeNumber int DEFAULT NULL,
creditLimit decimal(10,2) DEFAULT NULL CHECK (creditLimit >= 0), -- por defecto NULL y restricción de cantidad positiva
PRIMARY KEY (customerNumber), -- PK de nuestra tabla customers2
KEY salesRepEmployeeNumber (salesRepEmployeeNumber), -- OPCIONAL --> esta línea no es necesaria para la creación de nuestra tabla, crea in índice que beneficia a la rapidez de las busquedas
CONSTRAINT customers_ibfk_1 -- alias de la FK
	FOREIGN KEY (salesRepEmployeeNumber) -- columna de la tabla customers2, que tiene el mismo dato que la columna a la que queremos apuntar nuestra relación
    REFERENCES employees1 (employeeNumber) -- dónde apunta nuestra FK, en qué tabla y qué columna es
    ON UPDATE CASCADE -- al actualizar datos en la tabla madre, se actualizan en la tabla hija
    ON DELETE RESTRICT -- mayor restricción (similar a no poner nada), no nos deja borrar datos que tienen relaciones
);