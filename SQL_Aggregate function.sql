/*
MySQL submission for top earner question
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
	


/*
I tried to use window function to simplify the above code, but MySQL did work well with windown function. Not sure why.

here is the demo code to show MySQL did not work with window function
*/
select employee_id, dense_rank() over (order by salary) as rnk
from employee

/*
error report:
    ERROR 1064 (42000) at line 15: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '(order by salary) as rnk

    from employee' at line 1
*/

/*
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
