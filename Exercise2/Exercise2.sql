DROP DATABASE IF EXISTS pizzeria_db;
CREATE DATABASE pizzeria_db;
USE pizzeria_db;

CREATE TABLE provinces (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE locations (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL UNIQUE,
province_id INT NOT NULL,
FOREIGN KEY (province_id) REFERENCES provinces(id)
);

CREATE TABLE customers (
id INT  AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
address VARCHAR(50) NOT NULL,
postal_code VARCHAR(10) NOT NULL,
location_id INT NOT NULL,
phone VARCHAR(20) NOT NULL UNIQUE,
FOREIGN KEY (location_id) REFERENCES locations(id)
);

CREATE TABLE category (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE product (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20) NOT NULL,
description TEXT NOT NULL,
image VARCHAR(250) NOT NULL,
price DECIMAL(6,2)NOT NULL CHECK (price>=0),
category_id INT NOT NULL,
FOREIGN KEY (category_id) REFERENCES category(id)
);

CREATE TABLE stores (
id INT AUTO_INCREMENT PRIMARY KEY,
address VARCHAR(50) NOT NULL,
postal_code VARCHAR(15) NOT NULL,
location_id INT NOT NULL,
FOREIGN KEY (location_id) REFERENCES locations(id)
);

CREATE TABLE employees (
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR (50) NOT NULL,
nif VARCHAR(12) NOT NULL UNIQUE,
phone VARCHAR(20) NOT NULL UNIQUE,
role_work ENUM('cook', 'delivery') NOT NULL,
store_id INT NOT NULL,
FOREIGN KEY (store_id) REFERENCES stores(id)
);

CREATE TABLE orders (
id INT AUTO_INCREMENT PRIMARY KEY,
customer_id INT NOT NULL,
store_id INT NOT NULL,
order_date DATETIME NOT NULL,
order_type ENUM('pick_up', 'deliver') NOT NULL,
total_price DECIMAL(7,2) NOT NULL CHECK (total_price>=0),
FOREIGN KEY (customer_id) REFERENCES customers(id),
FOREIGN KEY (store_id) REFERENCES stores(id)
);

CREATE TABLE order_details (
order_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL CHECK (quantity > 0),
PRIMARY KEY (order_id, product_id),
FOREIGN KEY (order_id) REFERENCES orders(id),
FOREIGN KEY (product_id) REFERENCES product(id)
);

CREATE TABLE deliveries (
order_id INT NOT NULL,
delivery_person_id INT NOT NULL,
delivery_date DATETIME NOT NULL,
FOREIGN KEY (order_id) REFERENCES orders(id),
FOREIGN KEY (delivery_person_id) REFERENCES employees(id)
);

INSERT INTO provinces (name) VALUES
('Barcelona'),
('Madrid'),
('Valencia');

INSERT INTO locations (name, province_id) VALUES
('Barcelona', 1),
('Sabadell', 1),
('Madrid', 2),
('Valencia', 3);

INSERT INTO customers (first_name, last_name, address, postal_code, location_id, phone) VALUES
('Joan', 'Pérez', 'Carrer de Balmes 10', '08007', 1, '600123456'),
('Maria', 'García', 'Carrer de Pau Claris 25', '08010', 1, '600654321'),
('Luis', 'Martínez', 'Calle Gran Vía 45', '28013', 3, '600111222');

INSERT INTO category (name) VALUES
('Pizza'),
('Hamburguesa'),
('Bebida');

INSERT INTO product (name, description, image, price, category_id) VALUES
('Margarita', 'Tomato, mozzarella, basil', 'margarita.jpg', 8.50, 1),
('Pepperoni', 'Tomato, mozzarella, pepperoni', 'pepperoni.jpg', 9.50, 1),
('Cheeseburger', 'Cheeseburger with lettuce and tomato', 'cheeseburger.jpg', 6.00, 2),
('Coca-Cola', 'Soft drink', 'cocacola.jpg', 2.00, 3);


INSERT INTO stores (address, postal_code, location_id) VALUES
('Carrer de Balmes 50', '08007', 1),
('Calle Gran Vía 50', '28013', 3);

INSERT INTO employees (first_name, last_name, nif, phone, role_work, store_id) VALUES
('Carlos', 'Lopez', '12345678A', '600222333', 'cook', 1),
('Ana', 'Ramirez', '23456789B', '600333444', 'delivery', 1),
('Pedro', 'Santos', '34567890C', '600444555', 'delivery', 2);

INSERT INTO orders (customer_id, store_id, order_date, order_type, total_price) VALUES
(1, 1, '2025-10-29 13:00:00', 'deliver', 18.00),
(2, 1, '2025-10-29 14:30:00', 'pick_up', 11.50);

INSERT INTO order_details (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 4, 2),
(2, 2, 1),
(2, 3, 1);

INSERT INTO deliveries (order_id, delivery_person_id, delivery_date) VALUES
(1, 2, '2025-10-29 13:45:00');


