-- creating database for homework one. otherwise everyhting would be stored in master
create database for_homework_1
use for_homework_1

-- creating table and then changing Id columnt with "alter table"
create table [dbo].[student](
    [ID] int,
    [Name] nvarchar(50) Null,
    [age] int null
);
Alter table student
alter column ID int not null;

-- Unique constraint
create table [dbo].[product](
    [product_id] int UNIQUE,
    [product_name] NVARCHAR(20),
    [price] DECIMAL(10,2)
);