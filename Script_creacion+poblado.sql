/* 
SPRINT MÓDULO 3 - Base de datos TE LO VENDO
REGLAS DE NEGOCIO:
1) Cada proveedor debe informarnos el nombre del representante legal, su nombre corporativo, al menos 
dos teléfonos de contacto (y el nombre de quien recibe las llamadas), la categoría de sus productos 
(solo nos pueden indicar una categoría) y un correo electrónico para enviar la factura. Sabemos que la 
mayoría de los proveedores son de productos electrónicos. En general, los proveedores venden muchos productos.
2) Cada cliente tiene un nombre, apellido, dirección (solo pueden ingresar una).
3) TeLoVendo tiene diferentes productos. Cada producto tiene información sobre su precio, su categoría, 
proveedor y color. Los productos pueden tener muchos proveedores.
*/

# Primero creamos schema en base de datos
CREATE SCHEMA `telovendo`;
USE telovendo;

# Segundo, creamos usuario con privilegios sobre el schema
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL ON telovendo.* TO 'admin'@'localhost';

# Tercero, creamos las tablas según el diagrama Entidad Relación 
CREATE TABLE contacto_proveedor (
contacto_id int NOT NULL AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(50),
telefono1 INT NOT NULL,
telefono2 INT,
CONSTRAINT PRIMARY KEY (contacto_id));

CREATE TABLE proveedor (
proveedor_id INT NOT NULL AUTO_INCREMENT,
contacto_id INT NOT NULL,
representante_legal VARCHAR(50) NOT NULL,
nombre_corporativo VARCHAR(50) NOT NULL,
categoria_productos VARCHAR(50) NOT NULL,
correo VARCHAR(50) NOT NULL,
CONSTRAINT PRIMARY KEY (proveedor_id),
CONSTRAINT FOREIGN KEY (contacto_id)
REFERENCES contacto_proveedor(contacto_id));

CREATE TABLE producto (
producto_id INT NOT NULL AUTO_INCREMENT,
proveedor_id INT NOT NULL,
precio INT NOT NULL,
categoria VARCHAR(50) NOT NULL,
color  VARCHAR(50),
stock INT NOT NULL,
CONSTRAINT PRIMARY KEY(producto_id),
CONSTRAINT FOREIGN KEY(proveedor_id)
REFERENCES proveedor(proveedor_id));

CREATE TABLE direccion (
direccion_id INT NOT NULL AUTO_INCREMENT,
calle VARCHAR(50) NOT NULL,
numero VARCHAR(50) NOT NULL,
comuna VARCHAR(50) NOT NULL,
CONSTRAINT PRIMARY KEY (direccion_id));

CREATE TABLE cliente (
cliente_id INT NOT NULL AUTO_INCREMENT,
direccion_id INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(50) NOT NULL,
CONSTRAINT PRIMARY KEY(cliente_id),
CONSTRAINT FOREIGN KEY(direccion_id)
REFERENCES direccion(direccion_id));

CREATE TABLE registro_compras (
compra_id INT NOT NULL AUTO_INCREMENT,
cliente_id INT NOT NULL,
producto_id INT NOT NULL,
fecha_hora TIMESTAMP NOT NULL,
CONSTRAINT PRIMARY KEY(compra_id),
CONSTRAINT FOREIGN KEY (cliente_id)
REFERENCES cliente(cliente_id),
CONSTRAINT FOREIGN KEY (producto_id)
REFERENCES producto(producto_id));

#Cuarto, ingresamos datos (5 proveedores, 5 clientes y 10 productos)

INSERT INTO contacto_proveedor VALUES
(0, 'Juan', 'Sanchez', 2233445, 2244997),
(0, 'Camilo', 'Sotelo', 2288445, 2244887),
(0, 'Javiera', 'Ramirez', 2299445, 2244667),
(0, 'Cristian', 'Gomez', 2266445, 2244557),
(0, 'Diego', 'Casablanca', 2211445, 2244337);

INSERT INTO proveedor VALUES
(0, 1, 'Mauricio Muñoz', 'Tech SpA', 'Tecnología', 'techspa@correo.com'),
(0, 2, 'Sandra Castillo', 'Digital SA', 'Tecnología', 'digitalsa@correo.com'),
(0, 3, 'Erika Moreno', 'Importadora Moreno SpA', 'Oficina', 'impmoreno@correo.com'),
(0, 4, 'Santiago Salazar', 'ChileTechs SA', 'Tecnología', 'chiletecs@correo.com'),
(0, 5, 'Maria Bañados', 'Distribuidora Sencillo ERP', 'Oficina', 'distsencillo@correo.com');

INSERT INTO direccion VALUES
(0, 'Alameda', '3540', 'Santiago'),
(0, 'Arturo Prat', '771', 'Santiago'),
(0, 'Avenida Pajaritos', '2036', 'Estación Central'),
(0, 'Vicuña Mackena', '4589', 'La Florida'),
(0, 'Lo Contador', '304', 'Providencia');

INSERT INTO cliente VALUES 
(0, 1, 'Dominga', 'Lima'),
(0, 2, 'Clara', 'Luengo'),
(0, 3, 'Carlos', 'Perez'),
(0, 4, 'Sebastian', 'Zarate'),
(0, 5, 'Oscar', 'Ortiz');

INSERT INTO producto VALUES
(0, 1, 16990, 'Teclado', 'Negro', 47),
(0, 1, 12990, 'Mouse', 'Negro', 55),
(0, 2, 29990, 'Monitor', 'Negro', 21),
(0, 2, 9990, 'Mousepad', 'Morado', 59),
(0, 3, 4990, 'Resma tamaño Carta', 'Blanco', 150),
(0, 3, 4990, 'Resma tamaño Oficio', 'Blanco', 120),
(0, 4, 16990, 'Microfono', 'Negro', 43),
(0, 4, 24990, 'Brazo articulado', 'Negro', 100),
(0, 4, 2990, 'Portalápices', 'Plateado', 190),
(0, 5, 3490, 'Estuche', 'Azul', 200);
