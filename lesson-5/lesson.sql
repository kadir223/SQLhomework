-- Window functions

create database lesson_5
go 
use lesson_5



CREATE TABLE Sales (
    SaleID INT IDENTITY(1,1) PRIMARY KEY,
    SaleDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL
);


INSERT INTO Sales (SaleDate, Amount) VALUES
('2024-01-01', 100),
('2024-01-02', 200),
('2024-01-03', 150),
('2024-01-04', 300),
('2024-01-05', 250),
('2024-01-06', 400),
('2024-01-07', 350),
('2024-01-08', 450),
('2024-01-09', 500),
('2024-01-10', 100);



select * from Sales
--1 learning to use ROW_NUMBER, DENSE_RANK< RANK()
Select *, 
    Row_number() Over(Order by Amount) as RANK,
    DENSE_RANK() Over(Order by Amount DESC) as RANK_1,
    Rank() Over (Order by Amount desc) as rank_2
from Sales
Order by Rank_2;

--

