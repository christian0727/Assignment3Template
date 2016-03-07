-- 30 MARKS TOTAL

-- TODO: Database

-- Complete these tables (3 marks), 
-- inserts (1 mark) 
-- stored procedures (20 marks total)
-- reports (6 marks)

USE MASTER
GO
DROP DATABASE dbAssignment3
GO
CREATE DATABASE dbAssignment3
GO
USE dbAssignment3
GO
CREATE TABLE tbCustomer -- AccessLevel is a BIT, 1 is admin, 0 is not an admin
(
	CustomerID		INT PRIMARY KEY IDENTITY (1,1),
	FirstName		VARCHAR(MAX),
	LastName		VARCHAR(MAX),
	Address			VARCHAR(MAX),
	City		    VARCHAR(MAX),
	PhoneNumber		VARCHAR(MAX),
	UserName		VARCHAR(MAX),
	Password		VARCHAR(MAX),
	AccessLevel		BIT
)
CREATE TABLE tbCategory
(
	CategoryID		INT PRIMARY KEY IDENTITY (1,1), 
	Name			VARCHAR(MAX),
	ImagePath		VARCHAR(MAX)
)
CREATE TABLE tbProduct -- there are many products in a single category
(
	ProductID		INT PRIMARY KEY IDENTITY (1,1),
	Name			VARCHAR(MAX),
	Price			DECIMAL(7,2),
	PrimaryImagePath VARCHAR(MAX),
	CategoryID		INT REFERENCES tbCategory(CategoryID)
)
CREATE TABLE tbOrder -- an order happens on a date by a customer
(
	OrderID			INT PRIMARY KEY IDENTITY (1,1),
	OrderDate		DATE,
	PricePaid		DECIMAL(7,2),
	CustomerID		INT REFERENCES tbCustomer(CustomerID)
)
CREATE TABLE tbOrderDetail -- there can be many details in an order, each detail contains the product purchased, the price paid at the time for the product multiplied by the quantity
(
	OrderDetailsID	INT PRIMARY KEY IDENTITY (1,1),
	OrderID			INT REFERENCES tbOrder(OrderID),
	ProductID		INT REFERENCES tbProduct(ProductID),
	Quantity		INT,
	Subtotal		DECIMAL(7,2)
)

INSERT INTO tbCustomer -- 5, 1 admin, 4 non-admins
(FirstName, LastName, Address, City, PhoneNumber, UserName, Password, AccessLevel) VALUES
('Christian', 'Yusi', 'Banning Street', 'Winnipeg', '204-234-2123', 'chyus', '1234', 1),
('Frances', 'Yusi', 'White Street', 'Winnipeg', '204-123-4567', 'fravil', 'abcd', 0),
('Earl', 'Lagaya', 'Blue Street', 'Winnipeg', '204-345-2314', 'earl', 'qwerty', 0),
('Arjay', 'Candoy', 'Red Street', 'Winnipeg', '204-412-5673', 'arjay', 'zxcv', 0),
('Michael', 'Olazo', 'Black Street', 'Winnipeg', '204-456-2222', 'michael', 'asdf', 0)

INSERT INTO tbCategory -- 4 categories
(Name, ImagePath) VALUES
('Spirits', 'Spirits.jpg'),
('Liqueurs', 'Liqueurs.jpg'),
('Wines', 'Wines.jpg'),
('Beers', 'Beers.jpg')

INSERT INTO tbProduct  -- 6 products in category one, 3 products in category two, 1 in category three
(Name, PrimaryImagePath, Price, CategoryID) VALUES
('Mezcal', 'Mezcal.jpg', 58.12, 1),
('St.George', 'St.George.jpg', 43.56, 1),
('Teeling', 'Teeling.jpg', 44.25, 1),
('Cognac', 'Cognac.jpg', 70.33, 1),
('Pisco', 'Pisco.jpg', 30.13, 1),
('MartinMiller', 'MartinMiller.jpg', 32.89, 1),
('Molinari', 'Molinari.jpg', 43.23, 2),
('Marlee', 'Marlee.jpg', 56.24, 2),
('Somrus', 'Somrus.jpg', 34.78, 2),
('PondView', 'PondView.jpg', 67.23, 3)

INSERT INTO tbOrder    -- 3 example orders from the non-admins
(CustomerID, OrderDate, PricePaid) VALUES
(2, '02/25/2016', 88.50),
(3, '02/27/2016', 157.92),
(4, '02/29/2016', 164.59)

INSERT INTO tbOrderDetail -- one item on the first order, 3 items on the second order, 2 items on the third order
(OrderID, ProductID, Quantity, Subtotal) VALUES
(1, 3, 2, 88.50),
(2, 8, 1, 56.24),
(2, 1, 1, 58.12),
(2, 2, 1, 43.56),
(3, 5, 1, 30.13),
(3, 10, 2, 134.46)

-- NOTE: All Insert procs *MUST* return the new identity number of the primary key.
-- Example: if you use spInsertCategory after there are 4 categories, it should return the value 5.
-- If a procedure says: ByID, it means return ALL rows in the table if an ID is not supplied (ISNULL)
GO
CREATE PROC spGetCategoryByID
(
	@CategoryID		INT = NULL
)
AS BEGIN
	SELECT CategoryID, Name, './Images/' + ImagePath as ImagePath FROM tbCategory 
	WHERE CategoryID = ISNULL(@CategoryID, CategoryID)
END
GO
CREATE PROC spInsertCategory
(
	@Name			VARCHAR(MAX),
	@ImagePath		VARCHAR(MAX) = NULL
)
AS BEGIN
	INSERT INTO tbCategory (Name, ImagePath) 
	VALUES				   (@Name, ISNULL(@ImagePath, 'NoImages.jpg'))
	SELECT SCOPE_IDENTITY() AS 'NewCategoryID'
END
GO
CREATE PROC spDeleteCategory
(
	@CategoryID		INT
)
AS BEGIN
	DELETE FROM tbCategory where CategoryID = @CategoryID
END
GO
CREATE PROC spUpdateCategory
(
	@CategoryID		INT,
	@Name			VARCHAR(MAX),
	@ImagePath		VARCHAR(MAX) 
)
AS BEGIN
	UPDATE tbCategory SET
	Name =			@Name,
	ImagePath =		ISNULL(@ImagePath, ImagePath)
	WHERE CategoryID = @CategoryID
END
GO
CREATE PROC spLogin
(
	@UserName	    VARCHAR(MAX),
	@Password		VARCHAR(MAX)
)
AS BEGIN
	IF EXISTS (SELECT UserName, Password FROM tbCustomer where UserName = @UserName and Password = @Password)
		BEGIN
			SELECT * FROM tbCustomer WHERE UserName = @UserName and Password = @Password
		END
	ELSE 
		BEGIN
			SELECT 'Invalid' AS UserName
		END
END
GO
CREATE PROC spGetCustomerByID
(
	@CustomerID		INT = NULL
)
AS BEGIN
	SELECT * FROM tbCustomer
	WHERE CustomerID = ISNULL(@CustomerID, CustomerID)
END
GO
CREATE PROC spInsertCustomer
(
	@FirstName		VARCHAR(MAX),
	@LastName		VARCHAR(MAX),
	@Address		VARCHAR(MAX),
	@City		    VARCHAR(MAX),
	@PhoneNumber	VARCHAR(MAX),
	@UserName		VARCHAR(MAX),
	@Password		VARCHAR(MAX),
	@AccessLevel	BIT
)
AS BEGIN
	IF EXISTS (SELECT * FROM tbCustomer where UserName = @UserName)
		BEGIN
		SELECT 'UserTaken' as UserName
		END
	ELSE
		BEGIN
		INSERT INTO tbCustomer(FirstName, LastName, Address, City, PhoneNumber, UserName, Password, AccessLevel)
		VALUES				  (@FirstName, @LastName, @Address, @City, @PhoneNumber, @UserName, @Password, @AccessLevel)
		SELECT SCOPE_IDENTITY() AS 'NewCustomerID'
		END
END
GO
CREATE PROC spDeleteCustomer
(
	@CustomerID INT
)
AS BEGIN
	DELETE FROM tbCustomer WHERE CustomerID = @CustomerID
END
GO
CREATE PROC spUpdateCustomer
(
	@CustomerID		INT,
	@FirstName		VARCHAR(MAX),
	@LastName		VARCHAR(MAX),
	@Address		VARCHAR(MAX),
	@City		    VARCHAR(MAX),
	@PhoneNumber	VARCHAR(MAX),
	@UserName		VARCHAR(MAX),
	@Password		VARCHAR(MAX),
	@AccessLevel	BIT
)
AS BEGIN
	UPDATE tbCustomer SET
	FirstName =		@FirstName,
	LastName =		@LastName,
	Address =		@Address,
	City =			@City,
	PhoneNumber =	@PhoneNumber,
	UserName =		@UserName,
	Password =		@Password,
	AccessLevel =	@AccessLevel
	WHERE CustomerID = @CustomerID
END
GO
CREATE PROC spGetProductsByCategoryID
(
	@CategoryID		INT = NULL
)
AS BEGIN
	SELECT * FROM tbProduct
	WHERE CategoryID = ISNULL(@CategoryID, CategoryID)
END
GO
CREATE PROC spGetProductByID
(
	@ProductID		INT = NULL
)
AS BEGIN
	SELECT * FROM tbProduct
	WHERE ProductID = ISNULL(@ProductID, ProductID)
END
GO
CREATE PROC spInsertProduct
(
	@Name			VARCHAR(MAX),
	@Price			DECIMAL(7,2),
	@PrimaryImagePath VARCHAR(MAX) = NULL,
	@CategoryID		INT 
)
AS BEGIN
	INSERT INTO tbProduct (Name, Price, PrimaryImagePath, CategoryID)
	VALUES				  (@Name, @Price, ISNULL(@PrimaryImagePath, 'NoImages.jpg'), @CategoryID)
	SELECT SCOPE_IDENTITY() AS 'NewProductID'
END
GO
CREATE PROC spDeleteProduct
(
	@ProductID		INT
)
AS BEGIN
	DELETE FROM tbProduct WHERE ProductID = @ProductID
END
GO
CREATE PROC spUpdateProduct
(
	@ProductID		INT,
	@Name			VARCHAR(MAX),
	@Price			DECIMAL(7,2),
	@PrimaryImagePath VARCHAR(MAX) = null,
	@CategoryID		INT 
)
AS BEGIN
	UPDATE tbProduct SET
	Name =			@Name,
	Price =			@Price,
	PrimaryImagePath = ISNULL(@PrimaryImagePath, PrimaryImagePath),
	CategoryID =	@CategoryID
	WHERE ProductID = @ProductID
END
GO
CREATE PROC spGetOrderByID
(
	@OrderID		INT = NULL
)
AS BEGIN
	SELECT * FROM tbOrder
	WHERE OrderID = ISNULL(@OrderID, OrderID)
END
GO
CREATE PROC spInsertOrder
(
	@OrderDate		DATE,
	@PricePaid		DECIMAL(7,2),
	@CustomerID		INT
)
AS BEGIN
	INSERT INTO tbOrder (OrderDate, PricePaid, CustomerID)
	VALUES				(@OrderDate, @PricePaid, @CustomerID)
	SELECT SCOPE_IDENTITY() AS 'NewOrderID'
END
GO
CREATE PROC spDeleteOrder
(
	@OrderID		INT
)
AS BEGIN
	DELETE FROM tbOrder WHERE OrderID = @OrderID
END
GO
CREATE PROC spUpdateOrder
(
	@OrderID		INT,
	@OrderDate		DATE,
	@PricePaid		DECIMAL(7,2),
	@CustomerID		INT
)
AS BEGIN
	UPDATE tbOrder SET
	OrderDate =		@OrderDate,
	PricePaid =		@PricePaid,
	CustomerID =	@CustomerID
	WHERE OrderID = @OrderID
END
GO
CREATE PROC spGetOrderDetailByID
(
	@OrderDetailsID		INT = NULL
)
AS BEGIN
	SELECT * FROM tbOrderDetail
	WHERE OrderDetailsID = ISNULL(@OrderDetailsID, OrderDetailsID)
END
GO
CREATE PROC spInsertOrderDetail
(
	@OrderID		INT,
	@ProductID		INT,
	@Quantity		INT,
	@Subtotal		DECIMAL(7,2)
)
AS BEGIN
	INSERT INTO tbOrderDetail (OrderID, ProductID, Quantity, Subtotal)
	VALUES					  (@OrderID, @ProductID, @Quantity, @Subtotal)
	SELECT SCOPE_IDENTITY() AS 'NewOrderDetailsID'
END
GO
CREATE PROC spDeleteOrderDetail
(
	@OrderDetailsID		INT
)
AS BEGIN
	DELETE FROM tbOrderDetail WHERE OrderDetailsID = @OrderDetailsID
END
GO
CREATE PROC spUpdateOrderDetail
(
	@OrderDetailsID	INT,
	@OrderID		INT,
	@ProductID		INT,
	@Quantity		INT,
	@Subtotal		DECIMAL(7,2)
)
AS BEGIN
	UPDATE tbOrderDetail SET
	OrderID =		@OrderID,
	ProductID =		@ProductID,
	Quantity =		@Quantity,
	Subtotal =		@Subtotal
	WHERE OrderDetailsID = @OrderDetailsID
END
GO
CREATE PROC spGetOrderAndDetailsByOrderID -- Show all Details based on the OrderID
(
	@OrderID		INT = NULL
)
AS BEGIN
	SELECT tbOrder.OrderID, OrderDate, PricePaid, OrderDetailsID, FirstName, Name, Price, Quantity, Subtotal FROM tbOrder 
	JOIN tbOrderDetail ON tbOrder.OrderID = tbOrderDetail.OrderID
	JOIN tbCustomer ON tbOrder.CustomerID = tbCustomer.CustomerID
	JOIN tbProduct ON tbProduct.ProductID = tbOrderDetail.ProductID
	WHERE tbOrder.OrderID = ISNULL(@OrderID, tbOrder.OrderID)
END
GO

-- Create these reports:
--1. Top 3 Customers for TOTAL spent among all orders
SELECT TOP 3 tbCustomer.CustomerID, UserName, FirstName, SUM(PricePaid) AS 'TOTAL SPENT' FROM tbCustomer 
JOIN tbOrder ON tbCustomer.CustomerID = tbOrder.CustomerID
GROUP BY tbCustomer.CustomerID, UserName, FirstName
ORDER BY [TOTAL SPENT] DESC

--2. Show each category and how many products are available in each
SELECT tbCategory.Name, COUNT(*) as 'PRODUCT COUNT' FROM tbCategory 
JOIN tbProduct ON tbCategory.CategoryID = tbProduct.CategoryID
GROUP BY tbCategory.Name

--3. Show the products listed by total amount paid (take into consideration quantity & price)
SELECT Name, SUM(Price * Quantity) as 'TOTAL AMOUNT PAID' FROM tbProduct 
JOIN tbOrderDetail ON tbProduct.ProductID = tbOrderDetail.ProductID
GROUP BY Name
ORDER BY [TOTAL AMOUNT PAID] desc

select * from tbOrder