create database homework_4
use homework_4


--Task 1. 

CREATE TABLE [dbo].[TestMultipleZero]
(
    [A] [int] NULL,
    [B] [int] NULL,
    [C] [int] NULL,
    [D] [int] NULL
);
GO

INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

--

SELECT A, B, C, D
FROM TestMultipleZero
WHERE A!=0 OR B!=0 OR C!=0 OR D!=0;


--TASK 2 

CREATE TABLE TestMax
(
    Year1 INT
    ,Max1 INT
    ,Max2 INT
    ,Max3 INT
);
GO
 
INSERT INTO TestMax 
VALUES
    (2001,10,101,87)
    ,(2002,103,19,88)
    ,(2003,21,23,89)
    ,(2004,27,28,91);

Select * from TestMax

SELECT Year1, 
    CASE 
        WHEN Max1>=MAX2 and max1>=max3 then max1
        when max2>=max1 and max2>=max3 then max2
        else max3
    end as maxvalue_column
from TestMax

select year1, greatest(max1, max2, max3) as greatest from testmax
--ALTernative but more complex solution. we use UNPIVOT to make columns as rows and use MAX()




--Task 3. 
CREATE TABLE EmpBirth
(
    EmpId INT  IDENTITY(1,1) 
    ,EmpName VARCHAR(50) 
    ,BirthDate DATETIME 
);
 
INSERT INTO EmpBirth(EmpName,BirthDate)
SELECT 'Pawan' , '12/04/1983'
UNION ALL
SELECT 'Zuzu' , '11/28/1986'
UNION ALL
SELECT 'Parveen', '05/07/1977'
UNION ALL
SELECT 'Mahesh', '01/13/1983'
UNION ALL
SELECT'Ramesh', '05/09/1983';

--
SELECT EmpID, EmpName, BirthDate
FROM EmpBirth
WHERE DATEPART(MONTH, BirthDate) = 5
AND DATEPART(DAY, BirthDate) BETWEEN 7 AND 15



--Task4

create table letters
(letter char(1));

insert into letters
values ('a'), ('a'), ('a'), 
  ('b'), ('c'), ('d'), ('e'), ('f');

-- b first

SELECT letter
FROM letters
ORDER BY CASE WHEN letter='b' THEN 0 ELSE 1 END

--b last

SELECT letter
FROM letters
ORDER BY CASE WHEN letter='b' THEN 1 ELSE 0 END

