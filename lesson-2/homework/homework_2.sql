create database homework_2
GO
use  homework_2

--1. DELETE vs TRUNCATE vs DROP (with IDENTITY example)
CREATE TABLE test_identity(
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO test_identity(name)
VALUES
('Akbar'),
('Shavkat'),
('Qodirbek'),
('Sardor'),
('Jahongir');
Select * from test_identity
--Delete
DELETE FROM test_identity


-- Check if identity resets (it doesn't)
INSERT INTO test_identity (name) VALUES ('Frank');
SELECT * FROM test_identity; -- id will be 6


--Test Case 2: TRUNCATE
--Answers to Questions

TRUNCATE TABLE test_identity;

DROP TABLE test_identity;



-- What happens to the identity column when you use DELETE?
-- The rows are removed, but the identity seed is not reset. 
--The next inserted row continues with the next identity value
-- (e.g., if the last id was 5, the next will be 6).
-- What happens to the identity column when you use TRUNCATE?
-- All rows are removed, and the identity seed is reset to its 
--initial value (e.g., 1 for IDENTITY(1,1)).
-- What happens to the table when you use DROP?
-- The entire table (structure and data) is deleted. 
--Any attempt to access the table results in an error 
--because it no longer exists.




--TASK 2

CREATE TABLE data_types_demo(
    id INT PRIMARY KEY,
    name VARCHAR(50),--nvarchar- supports unicode(numebr of signs maximum can be assigned)
    code CHAR(10),-- nchar- supports unicode (numebr of signs, will be filled with spaces if not full)
    salary DECIMAL(10,2),-- for decimal numebrs.  can be exchanged with NUMERICAL(max digits, digits after dot)
    hire_date DATE,-- DATE in format of YYYY-MM-DD
    last_login DATETIME,
    is_active BIT, 
    temperature FLOAT);

INSERT INTO data_types_demo (id, name, code, salary, hire_date, last_login, is_active, temperature)
VALUES (1, 'John Doe', 'EMP001    ', 75000.50, '2023-01-15', '2025-05-11 09:30:00', 1, 98.6);

SELECT * FROM data_types_demo


--TASK 3
CREATE TABLE [dbo].[photos](
    id INT PRIMARY KEY,
    photo VARBINARY(MAX)
);

INSERT INTO photos (id, photo)
SELECT 1, BulkColumn
FROM OPENROWSET(BULK '/var/opt/mssql/girl.jpg', SINGLE_BLOB) AS ImageData;

--Task 4
CREATE TABLE student(
    id INT PRIMARY KEY,
    name NVARCHAR(50),
    classes INT,
    tution_per_class DECIMAL(10,2),
    total_tution AS (classes*tution_per_class)
);

INSERT INTO student (id, name, classes, tution_per_class)
VALUES (1, 'Alice', 3, 500.00),
       (2, 'Bob', 5, 450.00),
       (3, 'Charlie', 2, 600.00);

SELECT * FROM student


--Task 5 
CREATE TABLE worker(
    id INT PRIMARY KEY,
    name varchar(50)
);

bulk insert worker 
from '/var/opt/mssql/sample.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2 -- Skip header row
);

-- Verify imported data
SELECT * FROM worker;