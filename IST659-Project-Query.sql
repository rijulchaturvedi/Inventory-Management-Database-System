-- Down Scripts
BEGIN TRANSACTION;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME='FK_OrderDetail_ProductID')
    ALTER TABLE OrderDetail DROP CONSTRAINT FK_OrderDetail_ProductID;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME='FK_OrderDetail_CustomerOrderID')
    ALTER TABLE OrderDetail DROP CONSTRAINT FK_OrderDetail_CustomerOrderID;

DROP TABLE IF EXISTS OrderDetail;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME='FK_Stock_ProductID')
    ALTER TABLE Stock DROP CONSTRAINT FK_Stock_ProductID;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME='FK_Stock_WarehouseID')
    ALTER TABLE Stock DROP CONSTRAINT FK_Stock_WarehouseID;

DROP TABLE IF EXISTS Stock;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME='FK_CustomerOrder_CustomerID')
    ALTER TABLE CustomerOrder DROP CONSTRAINT FK_CustomerOrder_CustomerID;

DROP TABLE IF EXISTS CustomerOrder;

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE CONSTRAINT_NAME='FK_Product_SupplierID')
    ALTER TABLE Product DROP CONSTRAINT FK_Product_SupplierID;

DROP TABLE IF EXISTS Product;

DROP TABLE IF EXISTS Warehouse;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Supplier;

COMMIT;

-- Up Scripts
BEGIN TRANSACTION;

CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100),
    ContactName VARCHAR(100),
    Address VARCHAR(200),
    City VARCHAR(50),
    PostalCode VARCHAR(20),
    Country VARCHAR(50),
    Phone VARCHAR(20)
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    ContactName VARCHAR(100),
    Address VARCHAR(200),
    City VARCHAR(50),
    PostalCode VARCHAR(20),
    Country VARCHAR(50),
    Phone VARCHAR(20)
);

CREATE TABLE Warehouse (
    WarehouseID INT PRIMARY KEY,
    WarehouseName VARCHAR(100),
    Address VARCHAR(200),
    City VARCHAR(50),
    PostalCode VARCHAR(20),
    Country VARCHAR(50)
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    SupplierID INT,
    UnitPrice DECIMAL(10, 2),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

CREATE TABLE CustomerOrder (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE OrderDetail (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES CustomerOrder(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE Stock (
    StockID INT PRIMARY KEY,
    ProductID INT,
    WarehouseID INT,
    Quantity INT,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID)
);

COMMIT;

-- Insert data into Supplier table
INSERT INTO Supplier (SupplierID, SupplierName, ContactName, Address, City, PostalCode, Country, Phone)
VALUES 
(1, 'Acme Corp', 'John Doe', '1234 Street', 'New York', '10001', 'USA', '123-456-7890'),
(2, 'Globex Corp', 'Hank Scorpio', '5678 Avenue', 'Cypress Creek', '20001', 'USA', '234-567-8901'),
(3, 'Soylent Corp', 'Richard Nixon', '91011 Street', 'Springfield', '30002', 'USA', '345-678-9012'),
(4, 'Initech', 'Bill Lumbergh', '121314 Avenue', 'Initech Park', '40003', 'USA', '456-789-0123'),
(5, 'Umbrella Corp', 'Albert Wesker', '151617 Street', 'Raccoon City', '50004', 'USA', '567-890-1234'),
(6, 'Wonka Industries', 'Willy Wonka', '192021 Street', 'Wonka Town', '60005', 'USA', '678-901-2345'),
(7, 'Stark Industries', 'Tony Stark', '222324 Avenue', 'New York', '10002', 'USA', '789-012-3456'),
(8, 'Wayne Enterprises', 'Bruce Wayne', '252627 Street', 'Gotham', '70006', 'USA', '890-123-4567'),
(9, 'Oscorp', 'Norman Osborn', '282930 Avenue', 'New York', '10003', 'USA', '901-234-5678'),
(10, 'Cyberdyne Systems', 'Miles Dyson', '313233 Street', 'Los Angeles', '90002', 'USA', '012-345-6789');

-- Insert data into Customer table
INSERT INTO Customer (CustomerID, CustomerName, ContactName, Address, City, PostalCode, Country, Phone)
VALUES 
(1, 'Jane Smith', 'Jane Smith', '5678 Avenue', 'Los Angeles', '90001', 'USA', '123-456-7890'),
(2, 'John Doe', 'John Doe', '91011 Street', 'San Francisco', '94101', 'USA', '234-567-8901'),
(3, 'Alice Johnson', 'Alice Johnson', '121314 Avenue', 'Chicago', '60601', 'USA', '345-678-9012'),
(4, 'Bob Williams', 'Bob Williams', '151617 Street', 'Houston', '77001', 'USA', '456-789-0123'),
(5, 'Charlie Brown', 'Charlie Brown', '181920 Avenue', 'Phoenix', '85001', 'USA', '567-890-1234'),
(6, 'David Johnson', 'David Johnson', '212223 Street', 'Philadelphia', '19101', 'USA', '678-901-2345'),
(7, 'Emily Davis', 'Emily Davis', '242526 Avenue', 'San Antonio', '78201', 'USA', '789-012-3456'),
(8, 'Frank Miller', 'Frank Miller', '272829 Street', 'San Diego', '92101', 'USA', '890-123-4567'),
(9, 'Grace Lee', 'Grace Lee', '303132 Avenue', 'Dallas', '75201', 'USA', '901-234-5678'),
(10, 'Harry Wilson', 'Harry Wilson', '333435 Street', 'San Jose', '95101', 'USA', '012-345-6789');

-- Insert data into Warehouse table
INSERT INTO Warehouse (WarehouseID, WarehouseName, Address, City, PostalCode, Country)
VALUES 
(1, 'Warehouse 1', '1234 Street', 'New York', '10001', 'USA'),
(2, 'Warehouse 2', '5678 Avenue', 'Los Angeles', '90001', 'USA'),
(3, 'Warehouse 3', '91011 Street', 'Chicago', '60601', 'USA'),
(4, 'Warehouse 4', '121314 Avenue', 'Houston', '77001', 'USA'),
(5, 'Warehouse 5', '151617 Street', 'Phoenix', '85001', 'USA'),
(6, 'Warehouse 6', '181920 Avenue', 'Philadelphia', '19101', 'USA'),
(7, 'Warehouse 7', '212223 Street', 'San Antonio', '78201', 'USA'),
(8, 'Warehouse 8', '242526 Avenue', 'San Diego', '92101', 'USA'),
(9, 'Warehouse 9', '272829 Street', 'Dallas', '75201', 'USA'),
(10, 'Warehouse 10', '303132 Avenue', 'San Jose', '95101', 'USA');

-- Insert data into Product table
INSERT INTO Product (ProductID, ProductName, SupplierID, UnitPrice)
VALUES 
(1, 'Product 1', 1, 10.00),
(2, 'Product 2', 2, 20.00),
(3, 'Product 3', 3, 30.00),
(4, 'Product 4', 4, 40.00),
(5, 'Product 5', 5, 50.00),
(6, 'Product 6', 6, 60.00),
(7, 'Product 7', 7, 70.00),
(8, 'Product 8', 8, 80.00),
(9, 'Product 9', 9, 90.00),
(10, 'Product 10', 10, 100.00);

-- Insert data into CustomerOrder table
INSERT INTO CustomerOrder (OrderID, CustomerID, OrderDate)
VALUES 
(1, 1, '2024-04-19'),
(2, 2, '2024-04-18'),
(3, 3, '2024-04-17'),
(4, 4, '2024-04-16'),
(5, 5, '2024-04-15'),
(6, 6, '2024-04-14'),
(7, 7, '2024-04-13'),
(8, 8, '2024-04-12'),
(9, 9, '2024-04-11'),
(10, 10, '2024-04-10');

-- Insert data into OrderDetail table
INSERT INTO OrderDetail (OrderDetailID, OrderID, ProductID, Quantity)
VALUES 
(1, 1, 1, 10),
(2, 2, 2, 20),
(3, 3, 3, 30),
(4, 4, 4, 40),
(5, 5, 5, 50),
(6, 6, 6, 60),
(7, 7, 7, 70),
(8, 8, 8, 80),
(9, 9, 9, 90),
(10, 10, 10, 100);

-- Insert data into Stock table
INSERT INTO Stock (StockID, ProductID, WarehouseID, Quantity)
VALUES 
(1, 1, 1, 100),
(2, 2, 2, 200),
(3, 3, 3, 300),
(4, 4, 4, 400),
(5, 5, 5, 500),
(6, 6, 6, 600),
(7, 7, 7, 700),
(8, 8, 8, 800),
(9, 9, 9, 900),
(10, 10, 10, 1000);

-- Select all records from Supplier table
SELECT * FROM Supplier;

-- Select all records from Customer table
SELECT * FROM Customer;

-- Select all records from Warehouse table
SELECT * FROM Warehouse;

-- Select all records from Product table
SELECT * FROM Product;

-- Select all records from CustomerOrder table
SELECT * FROM CustomerOrder;

-- Select all records from OrderDetail table
SELECT * FROM OrderDetail;

-- Select all records from Stock table
SELECT * FROM Stock;


-- Which suppliers supply the most products?
SELECT SupplierName, COUNT(ProductID) as NumberOfProducts
FROM Supplier
JOIN Product ON Supplier.SupplierID = Product.SupplierID
GROUP BY SupplierName
ORDER BY NumberOfProducts DESC;

-- Which customers have made the most orders?
SELECT CustomerName, COUNT(OrderID) as NumberOfOrders
FROM Customer
JOIN CustomerOrder ON Customer.CustomerID = CustomerOrder.CustomerID
GROUP BY CustomerName
ORDER BY NumberOfOrders DESC;

-- What are the top five products with the highest quantity in stock?
SELECT ProductName, SUM(Quantity) as TotalQuantity
FROM Product
JOIN Stock ON Product.ProductID = Stock.ProductID
GROUP BY ProductName
ORDER BY TotalQuantity DESC
--LIMIT 5;

-- Which products have the highest sales?
SELECT ProductName, SUM(Quantity) as TotalSales
FROM Product
JOIN OrderDetail ON Product.ProductID = OrderDetail.ProductID
GROUP BY ProductName
ORDER BY TotalSales DESC;


-- Procedure to update a product's supplier
DROP PROCEDURE IF EXISTS p_upsert_product_supplier;
CREATE PROCEDURE p_upsert_product_supplier (
    @product_id INT,
    @supplier_id INT
) AS BEGIN
    IF EXISTS(SELECT * FROM Product WHERE ProductID = @product_id) BEGIN 
        UPDATE Product SET SupplierID = @supplier_id  
            WHERE ProductID = @product_id
    END
    ELSE BEGIN
        INSERT INTO Product (ProductID, SupplierID) 
            VALUES (@product_id, @supplier_id)
    END
END;

-- Test the procedure
EXEC p_upsert_product_supplier @product_id = 1, @supplier_id = 2;
SELECT * FROM Product WHERE ProductID = 1;

-- Procedure to update a customer's address
DROP PROCEDURE IF EXISTS p_upsert_customer_address;
CREATE PROCEDURE p_upsert_customer_address (
    @customer_id INT,
    @new_address VARCHAR(255)
) AS BEGIN
    IF EXISTS(SELECT * FROM Customer WHERE CustomerID = @customer_id) BEGIN 
        UPDATE Customer SET Address = @new_address  
            WHERE CustomerID = @customer_id
    END
    ELSE BEGIN
        INSERT INTO Customer (CustomerID, Address) 
            VALUES (@customer_id, @new_address)
    END
END;

-- Test the procedure
EXEC p_upsert_customer_address @customer_id = 1, @new_address = '123 New Street, New City';
SELECT * FROM Customer WHERE CustomerID = 1;

-- Trigger to update stock quantity after an order
DROP TRIGGER IF EXISTS t_update_stock;
CREATE TRIGGER t_update_stock
    AFTER INSERT ON OrderDetail
    FOR EACH ROW BEGIN
        UPDATE Stock
        SET Quantity = Quantity - NEW.Quantity
        WHERE ProductID = NEW.ProductID;
    END;

-- Test the trigger
INSERT INTO OrderDetail (OrderID, ProductID, Quantity) VALUES (1, 1, 10);
SELECT * FROM Stock WHERE ProductID = 1;

-- Trigger to update product sales after an order
DROP TRIGGER IF EXISTS t_update_product_sales;
CREATE TRIGGER t_update_product_sales
    AFTER INSERT ON OrderDetail
    FOR EACH ROW BEGIN
        UPDATE Product
        SET Sales = Sales + NEW.Quantity
        WHERE ProductID = NEW.ProductID;
    END;

-- Test the trigger
INSERT INTO OrderDetail (OrderID, ProductID, Quantity) VALUES (1, 1, 10);
SELECT * FROM Product WHERE ProductID = 1;
