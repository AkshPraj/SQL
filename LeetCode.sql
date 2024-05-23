
-- Calculate Special Bonus
-- Calculate the bonus of each employee. The bonus of an employee is 100% of their salary if the ID of 
-- the employee is an odd number and the employee name does not start with the character 'M'. The 
-- bonus of an employee is 0 otherwise.

select employee_id, 
    if(employee_id % 2 !=0 and name not like 'M%', salary*1, 0) as bonus
from employees;

-- or

select employee_id,
case when 
     employee_id % 2 != 0 and
     name not like 'M%'
     then salary
     else 0
     end as bonus
from employees
order by employee_id;

-- Find all customers who never order anything.
-- Return the result table in any order.

	select c.name as customers from 
	customers c left outer join orders o
	on c.id = o.customerId
	where o.id is null;

-- Write an SQL query to swap all 'f' and 'm' values (i.e., change all 'f' values to 'm' and vice 
-- versa) 

update salary 
set sex = 
case
when sex = 'm' then 'f'
when sex = 'f' then 'm'
end;

-- 1667. Fix Names in a Table
-- This table contains the ID and the name of the user. The name consists of only lowercase and
-- uppercase characters. 
-- Fix the names so that only the first character is uppercase and the rest are lowercase.
-- Return the result table ordered by user_id.

select user_id, 
    concat(upper(left(name,1)), lower(right(name, length(name) - 1))) as name 
from users
order by user_id;

-- 1484. Group Sold Products By The Date 
-- Each row of this table contains the product name and the date it was sold in a market.
-- Find for each date the number of different products sold and their names.
-- The sold products names for each date should be sorted lexicographically.(in order)
-- Return the result table ordered by sell_date

select sell_date, count(distinct product) as num_sold,
	group_concat(distinct product order by product) as product
from activities
group by sell_date
order by sell_date;


-- 1527. Patients With a Condition
-- Find the patient_id, patient_name and conditions of the patients who have Type I Diabetes. 
-- Type I Diabetes always starts with DIAB1 prefix.

select patient_id, patient_name, conditions
from patients
where conditions like "% DIAB%" or conditions like "DIAB%"
order by conditions;

-- 1965. Employees With Missing Information

-- Write an SQL query to report the IDs of all the employees with missing information.
-- The information of an employee is missing if:
-- The employee's name is missing, or
-- The employee's salary is missing.
-- Return the result table ordered by employee_id in ascending order.

select employee_id from employees 
 where employee_id not in(select employee_id from salaries)
union
select employee_id from salaries
where employee_id not in(select employee_id from employees)
order by employee_id asc;


-- 1148. Article Views I
-- Each row of this table indicates that some viewer viewed an article (written by some author) on -- some date. 
-- Note that equal author_id and viewer_id indicate the same person.
-- Find all the authors that viewed at least one of their own articles.
-- Return the result table sorted by id in ascending order.

select distinct author_id as id 
from views
where author_id = viewer_id
order by id;

-- 1683. Invalid Tweets
-- Find the IDs of the invalid tweets. The tweet is invalid if the number of characters used in 
-- the content of the tweet is strictly greater than 15.
-- Return the result table in any order.

select tweet_id from tweets
where length(content) > 15;

-- 1378. Replace Employee ID With The Unique Identifier
-- Show the unique ID of each user, If a user does not have a unique ID replace just show null.
-- Return the result table in any order.

select uni.unique_id, em.name
from employees as emp 
left join employeeUNI as uni
on emp.id = uni.id;

-- 1068. Product Sales Analysis I
-- Write an SQL query that reports the product_name, year, and price for each sale_id in the Sales table.

select p.product_name, s.year, s.price
from sales s join product p
on s.product_id = p.product_id;

-- 1581. Customer Who Visited but Did Not Make Any Transactions
-- Write a SQL query to find the IDs of the users who visited without making any transactions and 
-- the number of times they made these types of visits.
-- Return the result table sorted in any order.

select customer_id, count(v.visit_id) as count_no_trans from
visits v left join transactions t
on v.visit_id = t.visit_id
where t.visit_id is null
group by customer_id;

-- or

select customer_id, count(customer_id) as count_no_trans from visits 
where visit_id not in(select visit_id from transactions)
group by customer_id;


-- 197. Rising Temperature
-- This table contains information about the temperature on a certain day.
-- Find all dates Id with higher temperatures compared to its previous dates (yesterday).
-- Return the result table in any order.

select a.id from weather a inner join weather b
on dateDiff(a.recordDate, b.recordDate) = 1
and a.temperature > b.temperature;


-- 577. Employee Bonus
--  Write an SQL query to report the name and bonus amount of each employee with a bonus less than 1000.
-- Return the result table in any order.

select e.name, bonus as bonus from 
employee e left join bonus b
on e.empId = b.empId 
where b.bonus < 1000 and b.bonus is null;