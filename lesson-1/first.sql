create database hm1;
go
use hm1;
drop database hm1
drop table if exists depratment

use test;
create table [dbo].[newtable](
    id int NOT NULL ,
    [Departmentname] NVARCHAR(100) NOT NULL, 
    [Describtion] NVARCHAR(MAX) NULL
);

Select * from newtable; 

INSERT INto newtable
values
    ( 240159, 'Economics', ' good thing')