/*COMMON DATATYPES*/

-- integer:
--tinyint=(0,255)
-- samllint
-- int=(-2b, 2b)
-- bigint(-2^63, 2^63-1)
-- decimal(numer of digits, digits after dot)
-- float
create database learning_lesson_2; 
go
use learning_lesson_2; 
create table test (
    id TINYINT

);
insert into test
values (1),(2),(3);
insert into test 
values (257);

select * from test


/*string*/
--Char(numeber of signs), nchar(), varchar(), nvarchar()
-- text ntext

drop table if exists blog
create table blog(
    int int,
    title varchar(255),
    body varchar(max)
)


/* Dates and time*/
--2020-12-20 - date
-- 23:50 - time

--date=yyyy-mm-dd
--time= hh:mm:ss
--datetime= yyyy-mm-dd hh:mm:ss
-- date example:
create table person(
    name varchar(100),
    birth date
)
insert into person
select 'john', '2007-11-23'

select * FROM person

--time example
create table exam(
    subject varchar(50),
    exam_time time 
);
insert into exam
select 'python','14:25:55'

select * from exam


--datetime
select getdate()
create table [order](
    item varchar(50),
    price int,
    created_datetime datetime
);
insert into [order]
select 'apple', 1000, GETDATE()
SELECT SWITCHOFFSET(SYSDATETIMEOFFSET(), '+05:00');

select * from [order] 

select getutcdate()

--GUID
create table exm(
    id UNIQUEIDENTIFIER,
    name varchar(50)
);
select NEWID()

insert into exm
select newid(), 'john'

select * from exm

--saving file in database

create table products(
    id int primary key,
    name varchar(50),
    category_name varchar(50),
    photo_path varchar(50)--not the photo itself but path to it

);

--2nd method is directly saving the photo
drop table if exists products
create table products(
    id int primary key,
    name varchar(50),
    photo varbinary(max)
);

insert into products
select 1, 'walpaper', bulkcolumn from openrowset
( bulk '/data/girl.jpg', single_blob) as img 

select * from products

