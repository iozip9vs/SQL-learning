# SQL-learning

## primarily using MySQL, but will also use SQL Server, Oracle, SyBase. May also venture into Hardoop, MapReduce, NoSQL.

# 1. Basic operations

# 2. Aggregations
## 2.1 hackerrank site question on aggregation
This question gave the employee table, you can calculate total_earning as salary*months, then find the max of total earning among all the employees, finally find the count of top earner and the max earning. 

I first tried brutal force method:
step 1: find the total earning for each employees
select employee_id, salary*months as total_earning
from employee

step 2: find the max earning
select max(total_earning) as max_earning from (query from step 1)

step 3: find the count 
select (query from step 2) as max_earning, count(*) 
from (query from step 1)
where total_earning = (query from step 2)

This results in a very lengthy query with multiple layers of subquery.

Now I want to simplify it, and see if there is any potential to improve.

# 3. Strings

# 4. Subquery

# 5. Window Functions
