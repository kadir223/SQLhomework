create database homework_3
GO
USE homework_3

-- TASK ONE
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);
WITH topEmployees AS (
    SELECT TOP 10 PERCENT Department, Salary
    FROM Employees
    ORDER BY Salary DESC
)
SELECT 
    department,
    AVG(Salary) AS AverageSalary,
    Case
        WHEN AVG(salary)>80000 THEN 'High'
        WHEN AVG(salary) BETWEEN 50000 AND 80000 THEN 'Medium'
        ELSE 'low'
    END AS SalaryCategory
FROM Employees
GROUP BY Department
ORDER BY AverageSalary DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY


--TASK 2


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

SELECT
    CASE 
        WHEN Status IN ('Shipped','Delivered') THEN 'Completed'
        WHEN Status= 'Pending' THEN 'Pending'
        When Status= 'Cancelled' THEN 'Cancelled'
    END AS OrderStatus,
    COUNT(*) as Total_orders,
    SUM(TotalAmount) as Total_revenue
FROM Orders
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY CASE 
        WHEN Status IN ('Shipped','Delivered') THEN 'Completed'
        WHEN Status= 'Pending' THEN 'Pending'
        When Status= 'Cancelled' THEN 'Cancelled'
    END
Having SUM(TotalAmount)>5000
ORDER BY Total_revenue DESC


--task 3


CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

WITH MaxPrices AS (
    SELECT Category, MAX(Price) as MaxPrice
    FROM Products
    GROUP BY Category
)
SELECT p.Productname, p.Category, p.Price,
    IIF(p.Stock=0, 'Out of stock', IIF(p.Stock BETWEEN 1 AND 10, 'low stock','In stock'))
    as Inventory_status
FROM Products p

INNER JOIN MaxPrices mp ON p.Category=mp.Category AND p.Price=mp.MaxPrice
ORDER by p.Price DESC
OFFSET 5 ROWS








