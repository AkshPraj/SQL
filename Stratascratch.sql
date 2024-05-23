-- Workers With The Highest Salaries
-- You have been asked to find the job titles of the highest-paid employees.
-- Your output should include the highest-paid title or multiple titles with the same salary.

select t.worker_title from worker w
join title t
on w.worker_id = t.worker_ref_id
order by salary desc
limit 2;

select t.worker_title
from worker w join title t
on w.worker_id = t.worker_ref_id 
where salary in (select max(salary)
                    from worker);


-- Highest Salary In Department
-- Find the employee with the highest salary per department. 
-- Output the department name, employee's first name along with the corresponding salary.


SELECT
    department,
    first_name AS employee_name,
    salary
FROM employee
WHERE (department , salary) IN
        (SELECT department, MAX(salary)
        FROM employee         
        GROUP BY department
        );


-- Popularity of Hack
-- find the average popularity of the Hack per office location. 
-- Output the location along with the average popularity.

select fa.location , avg(h.popularity) from
facebook_employees fa join facebook_hack_survey h
on fa.id = h.employee_id
group by fa.location;

-- Top Cool Votes
-- Find the review_text that received the highest number of 'cool' votes. 
-- Output the business name along with the review text with the highest numbef of 'cool' votes.

select business_name, review_text
      from yelp_reviews
order by cool desc
limit 2;

select business_name, review_text 
from yelp_reviews
where cool = 
         (select max(cool) 
         from  yelp_reviews);


-- Top Businesses With Most Reviews
-- Find the top 5 businesses with most reviews
-- Assume that each row has a unique business_id such that the total reviews for each business is listed on each row.
-- Output the business name along with the total number of reviews and
-- order your results by the total reviews in descending order.

select name, sum(review_count) total_review
from yelp_business
group by business_id
order by total_review desc
limit 5;

-- Sum Of Numbers
-- Find the sum of numbers whose index is less than 5 and the sum of numbers whose index is greater than 5.
-- Output each result on a separate row.

-- Find all possible varieties which occur in either of the winemag datasets
-- Output unique variety values only. 
-- Sort records based on the variety in ascending order.

-- Activity Rank
-- Find the email activity rank for each user. 
-- The user with the highest number of emails sent will have a rank of 1, and so on
-- Output the user, total emails, and their activity rank. Order records by the total emails in descending order.

SELECT from_user, 
count(to_user) as total_email_sent,
ROW_NUMBER() OVER (order by count(to_user) desc, from_user asc) AS unique_rank
FROM google_gmail_emails
group by from_user;