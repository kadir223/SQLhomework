create database lesson_6
GO
use lesson_6

drop table if exists employee;
drop table if exists department;

create table department
(
	id int primary key identity,
	name varchar(50) not null,
	description varchar(max)
);

create table employee
(
	id int primary key identity,
	name varchar(50),
	salary int,
	dept_id int --foreign key references department(id)
);

insert into department(name)
values
	('IT'), ('Marketing'), ('HR'), ('Finance')

select * from department;


insert into employee(name, salary, dept_id)
values 
	('John', 15000, 4),
	('Josh', 12000, 5),
	('Adam', 9000, 2),
	('Smith', 11000, 4),
	('Doe', 10000, 1);

select * from employee;


select p.id 
from employee p
inner join department
    on department.id=p.dept_id