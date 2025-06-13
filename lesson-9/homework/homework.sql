create database homework_9
go
use homework_9

CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');

select * from Employees

;with Employeehierarchy as ( 
    select EmployeeID, ManagerID, JobTitle, 0 as depth
    from Employees
    where ManagerID is NULL

    UNION ALL

    select e.EmployeeID, e.ManagerID, e.JobTitle, 1+eh.depth
    from Employees e
    inner join Employeehierarchy eh 
    on e.ManagerID=eh.EmployeeID
)
select EmployeeID, ManagerID, JobTitle, depth
from Employeehierarchy
order by depth;



--factorial up to N
WITH Numbers AS (
    SELECT 1 AS Num
    UNION ALL
    SELECT Num + 1
    FROM Numbers
    WHERE Num < 10
),
Factorials AS (
    SELECT 1 AS Num, 1 AS Factorial
    UNION ALL
    SELECT n.Num, n.Num * f.Factorial AS Factorial
    FROM Numbers n
    INNER JOIN Factorials f ON f.Num = n.Num - 1
)
SELECT Num, Factorial
FROM Factorials
ORDER BY Num;

-- fibonacci
;WITH Fibonacci AS (
    SELECT 0 AS Position, 0 AS [Current], 1 AS [Next]
    UNION ALL
    SELECT Position + 1, [Next], [Current] + [Next]
    FROM Fibonacci
    WHERE Position < 10
)
SELECT Position, [Current] AS Value
FROM Fibonacci
ORDER BY Position;
