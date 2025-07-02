create database lesson_10;
GO
use lesson_10

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductName VARCHAR(100),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Orders VALUES 
	(1, 'Alice', '2024-03-01'),
	(2, 'Bob', '2024-03-02'),
	(3, 'Charlie', '2024-03-03');

INSERT INTO OrderDetails VALUES 
	(1, 1, 'Laptop', 1, 1000.00),
	(2, 1, 'Mouse', 2, 50.00),
	(3, 2, 'Phone', 1, 700.00),
	(4, 2, 'Charger', 1, 30.00),
	(5, 3, 'Tablet', 1, 400.00),
	(6, 3, 'Keyboard', 1, 80.00);


select * from orders
select * from OrderDetails


select a.OrderID, a.CustomerName, a.Quantity, a.UnitPrice
from (select o.OrderID, o.CustomerName, od.Quantity, od.UnitPrice,
    ROW_NUMBER() over (partition by o.CustomerName order by od.Unitprice desc) as rank
from orders o 
inner join OrderDetails od on o.OrderID=od.OrderID) as a
where a.rank=1

