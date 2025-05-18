create database homework_5
use homework_5

CREATE TABLE Employees(
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);
delete employees
INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
    ('Alice', 'HR', 50000, '2020-06-15'),
    ('Bob', 'HR', 60000, '2018-09-10'),
    ('Charlie', 'IT', 70000, '2019-03-05'),
    ('David', 'IT', 80000, '2021-07-22'),
    ('Eve', 'Finance', 90000, '2017-11-30'),
    ('Frank', 'Finance', 75000, '2019-12-25'),
    ('Grace', 'Marketing', 65000, '2016-05-14'),
    ('Hank', 'Marketing', 72000, '2019-10-08'),
    ('Ivy', 'IT', 67000, '2022-01-12'),
    ('Jack', 'HR', 52000, '2021-03-29');

select * from Employees

--1

SELECT EmployeeID, Name, Department, HireDate, Salary,
    ROW_NUMBER() OVER (ORDER By Salary DESC) AS Salary_rank
FROM Employees

--2
;with ranked_employees as (
    select *, 
    rank() over(order by salary desc) as salary_rank
    from Employees
),
Same_ranks as (
    Select salary_rank
    from ranked_employees
    group by salary_rank
    having count(*)>1
)
Select p.Department, p.EmployeeID, p.HireDate,p.Name,p.Salary, p.salary_rank
from ranked_employees p
inner join same_ranks s on s.salary_rank=p.salary_rank
order by p.salary_rank, p.name

--3. Identify the Top 2 Highest Salaries in Each Department
;

select * from Employees

Select EmployeeID, name, department, salary, hiredate, salary_rank
from (
    select EmployeeID, name, department, salary, hiredate,
    DENSE_RANK() Over(partition by department Order By salary desc) as salary_rank
    from Employees
) t
Where Salary_rank<=2
Order by department, salary_rank;

--4

Select EmployeeID, name, department, salary, hiredate, salary_rank
from (
    select EmployeeID, name, department, salary, hiredate,
    DENSE_RANK() Over(partition by department Order By salary) as salary_rank
    from Employees
) t
Where Salary_rank=1
Order by department, salary_rank;

--5
select *, 
    sum(salary) OVer(partition by department) as running_salary
from Employees
order by Department

--6
select *, 
    sum(salary) OVer(partition by department) as total_salary
from Employees
order by Department

--7
select *,
    AVG(salary) over (partition by department) as average_salary
from Employees
order by Department

--8
select *,
    Salary - avg(salary) over(partition by department) as DIFFERENCE_average
from Employees

--9
select *,
    avg(salary) over(order by EmployeeID rows between 1 preceding and 1 following)
from Employees

--10
Select sum(salary) as last_3
from (
    select salary,
        ROW_NUMBER() OVER(order by hiredate desc) as hirerank
    from Employees
) t 
where hirerank<=3

--11
Select *, 
    sum(salary) over (order by EmployeeID rows between unbounded preceding and current row)
from Employees

--12

select *,
   max(salary) over (order by EmployeeID rows between 2 preceding and 2 following) as max_salary
from Employees

--13
select *, 
    Cast(100*salary/(sum(salary) over(partition by department)) as DEcimal(10,2)) as perc_cont 
from Employees