create database homework_6
go
use homework_6
drop table employees, departments, projects

create table Employees(
    EmployeeID int PRIMARY key,
    Name NVARCHAR(10),
    department_id int,
    salary int
)

create table departments(
    Department_id int PRIMARY key,
    Department_name nvarchar(50)
)

create table projects(
    project_id int PRIMARY key,
    project_name nvarchar(10),
    employee_id int
)

INSERT INTO Employees (EmployeeID, Name, Department_ID, Salary) VALUES
(1, 'Alice', 101, 60000),
(2, 'Bob', 102, 70000),
(3, 'Charlie', 101, 65000),
(4, 'David', 103, 72000),
(5, 'Eva', NULL, 68000);

-- Insert into Departments
INSERT INTO Departments (Department_ID, Department_Name) VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');

-- Insert into Projects
INSERT INTO Projects (Project_ID, Project_Name, Employee_ID) VALUES
(1, 'Alpha', 1),
(2, 'Beta', 2),
(3, 'Gamma', 1),
(4, 'Delta', 4),
(5, 'Omega', NULL);



--INNER JOIN
--Write a query to get a list of employees along with their department names.

Select e.*, d.Department_name
from Employees e
join departments d
    on d.Department_id=e.department_id

--LEFT JOIN
--Write a query to list all employees, including those who are not assigned to any department.
Select e.*, d.Department_name
from Employees e
left join departments d 
    on d.Department_id=e.department_id

-- RIGHT JOIN
-- Write a query to list all departments, including those without employees.

select e.*,d.*
from Employees e
right join departments d 
    on d.Department_id=e.department_id

-- FULL OUTER JOIN
-- Write a query to retrieve all employees and all departments, even if there’s no match between them.
select e.*,d.*
from Employees e
full join departments d 
    on d.Department_id=e.department_id

-- JOIN with Aggregation
-- Write a query to find the total salary expense for each department.

SELECT d.*,
    sum(e.salary) as total_salary
from departments d 
left join Employees e on d.Department_id=e.department_id
group by d.Department_name, d.department_id

-- CROSS JOIN
-- Write a query to generate all possible combinations of departments and projects.
select * 
from Employees,departments

select * 
from Employees
cross join departments

-- MULTIPLE JOINS
-- Write a query to get a list of employees with 
--their department names and assigned project names. Include employees even if they don’t have a project.
select e.EmployeeID, e.Name,
    d.Department_name,
    p.project_name
from Employees e
left join departments d 
    on d.Department_id=e.department_id
left join [projects] p 
    on p.employee_id=e.EmployeeID