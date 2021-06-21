/* MySQL
MySQL submission for top earner question, brutal force is very complex:
Q1. find total_earning = salary*months (inner most query)
Q2. find max(total_earning) ==> single value
Q3. count those with total_earning equal to the max value (used Q2 twice, one in select, one in where)
*/
select 
	(
		select max(total) as max_total
		from (select employee_id, salary*months as total from employee) ta
	) as max_total,
	count(*) as  cnt
from (select employee_id, salary*months as total from employee) tb
where total = 
	(
		select max(total) as max_total
		from (select employee_id, salary*months as total from employee) ta
	);
	


/* MySQL
I tried to use window function to simplify the above code, but MySQL did work well with windown function. Not sure why.

here is the demo code to show MySQL did not work with window function
*/
select employee_id, dense_rank() over (order by salary) as rnk
from employee

/* MySQL
error report:
    ERROR 1064 (42000) at line 15: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '(order by salary) as rnk

    from employee' at line 1
*/

/* MS SQL Server
I used to work on MS SQL Server in my previous job, not sure what version. So tried here on SQL Server, and it worked well.
So it seems not my fault.
just found that other people also complained that hackerrank site MySQL does not support window function, sad.
*/
select avg(total_earning), count(*)
from (
select employee_id, 
    dense_rank() over (order by salary*months desc) as rnk, 
    salary*months as total_earning
from employee) a
where rnk = 1



/* MySQL and Oracle
station table, simple aggregation of sum.
tested in Oracle and MySQL, both worked, submitted both.
*/
select round(sum(lat_n),2), round(sum(long_w),2)
from station;

/* MySQL
aggregate, and truncate to 4 digits, require LAT_N in given range, 
TRUNCATE(N, D)
TRUNCATE(2.465,1) => 2.4
tested and submitted 
*/
select truncate(sum(lat_n),4)
from station
where lat_n > 38.7880 and lat_n < 137.2345

/* MySQL
another simple aggregation and truncate, tested and submitted  
*/
select truncate(max(LAT_N),4)
from station
where LAT_N < 137.2345