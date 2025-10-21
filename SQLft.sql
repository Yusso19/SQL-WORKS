-- 1) Создаём базу данных
CREATE DATABASE Market;
GO

-- Используем её
USE Market;
GO

-- 2) Создаём таблицу Products
CREATE TABLE Products (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);

-- 3) Добавляем новый столбец Brand
ALTER TABLE Products
ADD Brand NVARCHAR(50);

-- 4) Добавляем данные (пример: 10–15 записей)
INSERT INTO Products (Name, Price, Brand) VALUES
('Milk', 2.50, 'Milla'),
('Bread', 1.20, 'Araz'),
('Cheese', 8.70, 'Süd'),
('Rice', 3.40, 'Bahar'),
('Oil', 5.90, 'Golden'),
('Sugar', 4.10, 'SweetCo'),
('Coffee', 11.50, 'Nescafe'),
('Tea', 7.80, 'Beta'),
('Chocolate', 9.30, 'Milka'),
('Juice', 2.90, 'Jale'),
('Water', 1.00, 'Sirab'),
('Butter', 6.60, 'Lurpak'),
('Salt', 0.80, 'Azersalt');

-- 5) Обновим несколько данных (UPDATE)
UPDATE Products
SET Price = 12.00
WHERE Name = 'Coffee';

UPDATE Products
SET Brand = 'AzərSun'
WHERE Name = 'Oil';

-- 6) Удалим несколько записей (DELETE)
DELETE FROM Products
WHERE Name = 'Salt';

DELETE FROM Products
WHERE Price < 1.0;

-- 7) Найти продукты, чья цена меньше средней цены (AVG)
SELECT *
FROM Products
WHERE Price < (SELECT AVG(Price) FROM Products);

-- 8) Найти продукты с ценой больше 10
SELECT *
FROM Products
WHERE Price > 10;

-- 9) Найти продукты, у которых длина названия бренда больше 5
-- В выводе: ProductName + BrandName = ProductInfo
SELECT 
    CONCAT(Name, ' - ', Brand) AS ProductInfo
FROM Products
WHERE LEN(Brand) > 5;



---2 task
-- 1) Создаём таблицу Employee
CREATE TABLE Employee (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Fullname NVARCHAR(255) NOT NULL,
    Age INT NOT NULL CHECK (Age >= 0),
    Email NVARCHAR(255) UNIQUE NOT NULL,
    Salary DECIMAL(10,2) NOT NULL CHECK (Salary BETWEEN 300 AND 2000)
);

-- 2) Добавляем данные
INSERT INTO Employee (Fullname, Age, Email, Salary) VALUES
('John Smith', 29, 'john.smith@gmail.com', 1500.50),
('Aygun Huseynova', 32, 'aygun.h@gmail.com', 1800.75),
('Ali Mammadov', 22, 'ali.mammadov@gmail.com', 900.25),
('Leyla Karimova', 27, 'leyla.karimova@gmail.com', 1250.40),
('Tom Johnson', 35, 'tom.johnson@gmail.com', 1950.00);

-- 3) Примеры DML команд:
-- UPDATE — повысим зарплату
UPDATE Employee
SET Salary = Salary + 100
WHERE Fullname = 'Ali Mammadov';

-- DELETE — удалим сотрудника с низкой зарплатой
DELETE FROM Employee
WHERE Salary < 500;

-- SELECT — выведем всех сотрудников
SELECT * FROM Employee;

-- SELECT с агрегатами: средняя, макс и мин зарплата
SELECT 
    AVG(Salary) AS AvgSalary,
    MAX(Salary) AS MaxSalary,
    MIN(Salary) AS MinSalary
FROM Employee;
