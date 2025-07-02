create database homework_10;
go 
use homework_10



CREATE TABLE Shipments (
    N INT PRIMARY KEY,
    Num INT
);

INSERT INTO Shipments (N, Num) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1),
(9, 2), (10, 2), (11, 2), (12, 2), (13, 2), (14, 4), (15, 4), 
(16, 4), (17, 4), (18, 4), (19, 4), (20, 4), (21, 4), (22, 4), 
(23, 4), (24, 4), (25, 4), (26, 5), (27, 5), (28, 5), (29, 5), 
(30, 5), (31, 5), (32, 6), (33, 7);

;
With zeros As(
    select top 7 0 as NUM
    from master.dbo.spt_values
), 
allshipemtns  as (
    select Num from Shipments
    union ALL
    select num from zeros

),
ordered as (
    select num,
    ROW_NUMBER() over (order by num) as rn
    from allshipemtns
),
counted as (
    select count(*) as total_days from ordered
),
MedianTwo AS (
    SELECT o.Num
    FROM Ordered o
    CROSS JOIN Counted c
    WHERE o.rn = c.total_days / 2 OR o.rn = c.total_days / 2 + 1
)
SELECT AVG(CAST(Num AS FLOAT)) AS Median FROM MedianTwo;