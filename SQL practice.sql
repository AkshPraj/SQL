create database practice;
use practice;

create table activities(
sell_date date,
product varchar(40));

insert into activities
values('2020-05-30' , "Headphone"),
('2020-06-01' , "Pencil"),
('2020-06-02', "Mask"),
('2020-05-30', "Basketball"),
('2020-06-01' , "Bible"),
('2020-06-02' , "Mask"),
('2020-05-30' , "T-Shir");


-- Find for each date the number of different products sold and their names.
-- The sold products names for each date should be sorted lexicographically.(in order)
-- Return the result table ordered by sell_date.


select * from activities;


select sell_date, count(distinct product) as num_sold,
	group_concat(distinct product order by product) as product
from activities
group by sell_date
order by sell_date;

-- find the consecutive seats available in cinema
-- input table - cinema or theatre contains two columns
-- seat_id, free
-- seatIDs are always in sequence like 1,2,3,4,5 etc, whereas column free represents availability of the seat.

create table if not exists cinema(
seat_id int primary key,
free int);

insert into cinema 
values(1,1),
(2,0),
(3,1),
(4,1),
(5,1),
(6,0),
(7,0),
(8,0),
(9,1),
(10,1),
(11,1);


select * from cinema;


with seatgroup as(
select seat_id, free,
	seat_id - row_number() over(order by seat_id) as grp
from cinema
where free = 1
)

select min(seat_id) as start_seat,
	   max(seat_id) as end_seat,
	   count(*) as consecutive_seats
from seatgroup
group by grp
having count(*) > 1
order by start_seat;


-- two table product and supplier, product table contains 
-- product_idproduct_name,supplier_id,price 
-- supplier table contains supplier_id, supplier_name, country

create table product(
product_id int,
product_name varchar(20),	
supplier_id	int,
price decimal(4,2)
);

insert into product values
(1,	"Widget",101,25.50),
(2,"Gizmo",102	,15.75),
(3,	"Doodad",101,45.00),
(4,	"Thingamajig",103,55.00);

select * from product;

create table supplier(
supplier_id int primary key,
supplier_name varchar(20),
country varchar(10));

insert into supplier values
(101,"ABC Corp","USA"),
(102,"XYZ Inc","Canada"),
(103, "Def LTD", "USA");

select * from supplier;

-- sql query to find name of the product with the highest price in each country

select s.country, p.product_name, p.price as highest_price
from product p join supplier s
on p.supplier_id = s.supplier_id
where p.price = (select max(p2.price)
				from product p2 join supplier s2
				on p2.supplier_id = s2.supplier_id
                where s2.country = s.country);


-- you have two tables: customer and transaction,
-- customer table: customer_id, customer_name, registration_date
-- transaction table: transaction_id, customer_id, transaction_date, Amount


-- write sql query to calculate the total transaction amount for each customer for the current
-- year. the output should contain customer_name and total_amount

create table customer (
customer_id int primary key,
customer_name varchar(20),
registration_date date);

insert into customer values
(1	,"Alice"	,'2023-01-15'),
(2	,"Bob"	,'2022-07-23'),
(3	,"Charlie"	,'2021-11-30');

select * from customer;

create table transaction( 
transaction_id int primary key,
customer_id int,
transaction_date date,
amount decimal(5,2),
foreign key(customer_id) references customer(customer_id));

insert into transaction values
(101,1,	'2024-02-15',100.00),
(102,2,	'2024-03-22',200.00),
(103,1,	'2024-04-10',150.00),
(104,3,	'2023-12-30',250.00);

select * from transaction;

-- write sql query to calculate the total transaction amount for each customer for the current
-- year. the output should contain customer_name and total_amount

select c.customer_name, sum(t.amount) as total_transaction_amt
from customer c join transaction t
on  c.customer_id = t.customer_id
where year(t.transaction_date) = year(curdate())
group by c.customer_name;



-- Q1: Who is the senior most employee based on job title? 

SELECT title, last_name, first_name 
FROM employee
ORDER BY levels DESC
LIMIT 1;

-- Q2: Which countries have the most Invoices? 

SELECT COUNT(*) AS c, billing_country 
FROM invoice
GROUP BY billing_country
ORDER BY c DESC;

-- Q3: What are top 3 values of total invoice? 

SELECT total 
FROM invoice
ORDER BY total DESC
limit 3;

-- Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
-- Write a query that returns one city that has the highest sum of invoice totals. 
-- Return both the city name & sum of all invoice totals 

SELECT billing_city,SUM(total) AS InvoiceTotal
FROM invoice
GROUP BY billing_city
ORDER BY InvoiceTotal DESC
LIMIT 1;

-- Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the person who has spent the most money.

SELECT customer.customer_id, first_name, last_name, 
SUM(total) as total_spending  
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY total_spending desc