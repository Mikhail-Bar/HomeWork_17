CREATE DATABASE warehouse;

USE warehouse;

CREATE TABLE orders (
                        order_number INT PRIMARY KEY,
                        date DATE,
                        supplier_code INT,
                        balance_account INT,
                        document_code INT,
                        document_number INT,
                        material_code INT,
                        material_account INT,
                        unit_of_measurement_code INT,
                        quantity INT,
                        unit_price INT
);

CREATE TABLE material_classes (
                                  class_code INT PRIMARY KEY,
                                  group_code INT,
                                  material_name VARCHAR(255)
);

CREATE TABLE materials (
                           material_code INT PRIMARY KEY,
                           unit_of_measurement VARCHAR(50)
);

CREATE TABLE suppliers (
                           supplier_code INT PRIMARY KEY,
                           supplier_name VARCHAR(255),
                           tax_id VARCHAR(50),
                           legal_address VARCHAR(255),
                           bank_index INT,
                           bank_city VARCHAR(50),
                           bank_street VARCHAR(255),
                           bank_building INT,
                           bank_account_number INT
);

--1) посчитать количество поставщиков данного материала;
SELECT COUNT(*) AS supplier_count
FROM suppliers;
--2) предоставить возможность добавления единицы хранения с указанием всех реквизитов;
UPDATE orders
SET quantity = quantity + 1
WHERE material_code = 123;
--
INSERT INTO materials (material_code, material_name, unit_code)
VALUES (12345, 'Болты', 'шт.');
--3) вывести список поставщиков с указанием всех реквизитов данного материала на склад;
SELECT s.supplier_name, s.inn, s.legal_address, s.bank_address, s.bank_account, o.order_number, o.order_date, o.document_code, o.document_number, o.material_account, o.unit_code, o.material_quantity, o.unit_price
FROM suppliers s
         INNER JOIN orders o ON s.supplier_code = o.supplier_code
         INNER JOIN materials m ON o.material_code = m.material_code
WHERE m.material_name = 'Болты';
--4) для указанного адреса банка посчитать количество поставщиков склада, пользующихся услугами этого банка.
SELECT COUNT(DISTINCT suppliers.supplier_code)
FROM Suppliers
         INNER JOIN orders ON suppliers.supplier_code = orders.supplier_code
         INNER JOIN suppliers ON orders.balance_account = suppliers.bank_account_number
WHERE suppliers.bank_street = 'Улица' and suppliers.bank_building = 1