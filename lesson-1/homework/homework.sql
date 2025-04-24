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

-- UNIQUE CONSTRAINT
create table [dbo].[product](
    [product_id] int Constraint product_id_unique UNIQUE,
    [product_name] NVARCHAR(20),
    [price] DECIMAL(10,2)
);

alter table product
drop constraint product_id_unique

Alter table product
add constraint uq_product_id_name Unique (product_id, product_name)

--PRIMARY KEY
create table orders(
    order_id int PRIMARY KEY,
    customer_name nvarchar(50), 
    order_date DATE

)
--getting name of the primary key
select name 
from sys.key_constraints
where type='pk'and parent_object_id=object_id('orders')
--deleting the primary key
alter table orders
drop constraint PK__orders__4659622922972470
-- adding the primary key again
alter table orders
add constraint pk_order primary key (order_id)

-- Example of multi-column primary KEY
-- CREATE TABLE order_items (
--     order_id INT,
--     item_id INT,
--     quantity INT,
--     PRIMARY KEY (order_id, item_id)
-- );


-- FOREIGN KEY
create table category(
    category_id int primary KEY,
    category_name nvarchar(50)
)
create table item(
    item_id int primary key,
    item_name nvarchar(50),
    category_id int ,
    FOREIGN KEY (category_id) references category(category_id)
)
-- searching for name of the foreign key and thenn deleting the foreign key
select name
from sys.foreign_keys
where parent_object_id=object_id('item')
alter table item
drop CONSTRAINT FK__item__category_i__5165187F
--adding constraint back with name
alter table item
add constraint fk_item_category_id
FOREIGN KEY (category_id) REFERENCES category(category_id)

-- CHECK CONSTRAINT
create table account(
    account_id int PRIMARY KEY,
    balance DECIMAL(10,2) CHECK(balance>=0),
    account_type nvarchar(30) check (account_type in ('saving', 'cheking'))
)
select name 
from sys.check_constraints
where parent_object_id=object_id('account')

alter table account
drop constraint chek_account

alter table account 
add CONSTRAINT chek_account CHECK(
    balance>=0 and 
    account_type in ('saving','checking')
)

--checking the check constarint:
-- Should work
INSERT INTO account VALUES (5, 1000, 'Saving');

-- Should fail (negative balance)
INSERT INTO account VALUES (2, -50, 'Checking');

-- Should fail (invalid account type)
INSERT INTO account VALUES (3, 500, 'Business');

--DEFAULT CONSTRAINT
drop table if exists customer
create table customer(
    customer_id int primary key,
    name nvarchar(50),
    city nvarchar(50) DEFAULT 'unknown'

)
select name 
from sys.default_constraints
where parent_object_id=object_id('customer')

alter table customer
drop constraint DF__customer__city__5EBF139D

alter table customer
add constraint df_city default 'unknown' for city

-- Will use the default value
INSERT INTO customer (customer_id, name) 
VALUES (2, 'Bob');

-- Will override the default
INSERT INTO customer (customer_id, name, city) 
VALUES (3, 'Charlie', 'New York');


 -- IDENtity column

create table invoice(
    invoice_id int IDENTITY(1,1) PRIMARY KEY,-- starts at 1 and increases by 1
    amount decimal(10,2)
)
insert into invoice
values
    (200),
    (300);
insert into invoice(invoice_id, amount)
values (100,300)

set IDENTITY_INSERT invoice ON
set IDENTITY_INSERT invoice off


--all at once
create table books(
    book_id int IDENTITY(1,1) primary KEY,
    title NVARCHAR(100) not null,
    price decimal(10,2) check(price>0),
    genre nvarchar(50) default 'unknown'
)

INSERT INTO books (title, price, genre)
VALUES ('Deep Work', 30.00, 'Productivity');

-- Should fail (price not > 0)
INSERT INTO books (title, price) 
VALUES ('Free Book', 0);

-- Should fail (title is NULL)
INSERT INTO books (price) 
VALUES (25.00);


--library management system
drop table if exists member
create table book(
    book_id int identity(1,1) PRIMARY key,
    title nvarchar(100) not null,
    author nvarchar(100) not null,
    published_year int not null
)

create table member(
    member_id int PRIMARY key identity(1,1),
    name NVARCHAR(100) not null,
    email nvarchar(100) DEFAULT 'unknown',
    phone_number int not null

)
create table loan(
    loan_id int PRIMARY KEY identity(1,1),
    book_id int, foreign key (book_id) references book(book_id),
    member_id int, FOREIGN KEY (member_id) REFERENCES member(member_id),
    loan_date Date,
    return_date Date
)

INSERT INTO Book (title, author, published_year)
VALUES 
('To Kill a Mockingbird', 'Harper Lee', 1960),
('1984', 'George Orwell', 1949),
('The Alchemist', 'Paulo Coelho', 1988);

INSERT INTO Member (name, email, phone_number)
VALUES 
('Alice Smith', 'alice@example.com', '1234567890'),
('Bob Johnson', 'bob@example.com', '0987654321');

INSERT INTO Loan (book_id, member_id, loan_date, return_date)
VALUES 
(1, 1, '2025-04-01', '2025-04-15'),
(2, 2, '2025-04-03', NULL);  -- Still borrowed
