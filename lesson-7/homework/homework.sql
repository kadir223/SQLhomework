create database homework_7
go
use homework_7

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);


INSERT INTO Customers VALUES 
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

INSERT INTO Orders VALUES 
(101, 1, '2024-01-01'), (102, 1, '2024-02-15'),
(103, 2, '2024-03-10'), (104, 2, '2024-04-20');

INSERT INTO OrderDetails VALUES 
(1, 101, 1, 2, 10.00), (2, 101, 2, 1, 20.00),
(3, 102, 1, 3, 10.00), (4, 103, 3, 5, 15.00),
(5, 104, 1, 1, 10.00), (6, 104, 2, 2, 20.00);

INSERT INTO Products VALUES 
(1, 'Laptop', 'Electronics'), 
(2, 'Mouse', 'Electronics'),
(3, 'Book', 'Stationery');

SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM OrderDetails
Select * from Products

-- --1️ Retrieve All Customers With Their Orders (Include Customers Without Orders)

-- Use an appropriate JOIN to list all customers, their order IDs, and order dates.
-- Ensure that customers with no orders still appear.

Select c.CustomerName, o.OrderDate, od.Quantity, od.Price, p.ProductName, p.Category
from Customers c 
left join Orders o 
    on c.CustomerID=o.CustomerID
left join OrderDetails od 
    on o.OrderID=od.OrderID
left join Products p     
    on p.ProductID=od.ProductID


-- 2  Find Customers Who Have Never Placed an Order

-- Return customers who have no orders.

Select c.CustomerName
from Customers c
left JOIN Orders o 
    on o.CustomerID=c.CustomerID
where o.CustomerID is NULL;

-- List All Orders With Their Products

-- Show each order with its product names and quantity.



Select o.OrderDate, od.Quantity, od.Price, p.ProductName, p.Category
from Orders o
join OrderDetails od 
    on o.OrderID=od.OrderID
join Products p     
    on p.ProductID=od.ProductID

-- 4️ Find Customers With More Than One Order

-- List customers who have placed more than one order.

Select c.CustomerName
from Customers C 
join Orders o 
    on o.CustomerID=c.CustomerID
Group by c.CustomerName
HAVING Count(o.OrderID)>1

-- 5️ Find the Most Expensive Product in Each Order
;
with ranked_p as (
    select o.OrderDate,o.OrderID,p.ProductName,p.Category,
        Cast(od.Price/od.Quantity as decimal(10,2)) as Unit_price,
        ROW_NUMBER() over(Partition by o.OrderID order by od.price/od.quantity desc) as rank_price
    from Orders o
    join OrderDetails od 
        on o.OrderID=od.OrderID
    join Products p 
        on p.ProductID=od.ProductID
)
Select OrderId, OrderDate, ProductName, Category, Unit_price
from ranked_p
where rank_price=1

-- 6️ Find the Latest Order for Each Customer
;
with ranked_date as(
    select c.CustomerName , o.OrderDate, 
        ROW_NUMBER() over (partition by c.CustomerName Order by o.OrderDate desc) as date_rank
    from Customers C 
    join Orders o 
        on o.CustomerID=c.CustomerID
)
select CustomerName, OrderDate
from ranked_date
where date_rank=1

-- 7️ Find Customers Who Ordered Only 'Electronics' Products

-- List customers who only purchased items from the 'Electronics' category.

-- Select c.CustomerName, p.ProductName, p.Category
-- from Customers C 
-- join orders o 
--     on o.CustomerID=c.CustomerID
-- join OrderDetails Od 
--     on od.OrderID=o.OrderID
-- join Products p 
--     on p.ProductID=od.ProductID
-- where p.Category='Electronics'

Select C.CustomerName
from Customers c
where C.CustomerID in (
    Select o.CustomerID
    from Orders o
    join OrderDetails Od 
         on od.OrderID=o.OrderID
    join Products p 
         on p.ProductID=od.ProductID
    group by o.CustomerID
    having count(Distinct Case when p.Category<>'Electronics' Then 1 End) = 0
)



-- 8️ Find Customers Who Ordered at Least One 'Stationery' Product
-- List customers who have purchased at least one product from the 'Stationery' category.

SELECT DISTINCT c.CustomerName
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON od.OrderID = o.OrderID
JOIN Products p ON p.ProductID = od.ProductID
WHERE p.Category = 'Stationery';


-- 9️ Find Total Amount Spent by Each Customer
-- Show CustomerID, CustomerName, and TotalSpent.

SELECT 
    c.CustomerID,
    c.CustomerName,
    SUM(od.Quantity * od.Price) AS TotalSpent
FROM Customers c
JOIN Orders o ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON od.OrderID = o.OrderID
GROUP BY c.CustomerID, c.CustomerName;