
/* MySQL

Another monstrous code for MySQL.

Original question from Hackerrank site, asking for output of a list of hackers, 
with their name, and the number of challenges they created.
The twist is to disallow group of hackers if different people created the same number of challenges,
except those that created the max number of challenges.

This is my brutal force method:
1. build join table for hacker_id, name, and count_of_challenges by the hacker_id
2. find the counting of count_of_challenges, and only keep the counts=1 terms
3. find the max count_of_challenges
4. select from table (1) with count either in (2) or (3)

SQL in (1) is:
    select a.hacker_id, a.name, count(b.challenge_id) as cnt
    from hackers a inner join challenges b on a.hacker_id = b.hacker_id
    group by a.hacker_id, a.name
	
SQL in (2) is:
    select cnt
    from (
        select a.hacker_id, a.name, count(b.challenge_id) as cnt
        from hackers a inner join challenges b on a.hacker_id = b.hacker_id
        group by a.hacker_id, a.name
        ) x
    group by cnt
        having count(cnt)=1 
		
SQL in (3) is:
    select max(cnt)
    from (
        select a.hacker_id, a.name, count(b.challenge_id) as cnt
        from hackers a inner join challenges b on a.hacker_id = b.hacker_id
        group by a.hacker_id, a.name
        ) y

Final structure is:
select ....
from  (1)
where z.cnt in (2) or z.cnt in (3)
order by z.cnt desc, z.hacker_id
*/


select z.hacker_id, z.name, z.cnt
from (
    select a.hacker_id, a.name, count(b.challenge_id) as cnt
    from hackers a inner join challenges b on a.hacker_id = b.hacker_id
    group by a.hacker_id, a.name
) z
where z.cnt in (
    select cnt
    from (
        select a.hacker_id, a.name, count(b.challenge_id) as cnt
        from hackers a inner join challenges b on a.hacker_id = b.hacker_id
        group by a.hacker_id, a.name
        ) x
    group by cnt
        having count(cnt)=1 
)
or
z.cnt in (
    select max(cnt)
    from (
        select a.hacker_id, a.name, count(b.challenge_id) as cnt
        from hackers a inner join challenges b on a.hacker_id = b.hacker_id
        group by a.hacker_id, a.name
        ) y
)
order by z.cnt desc, z.hacker_id

/*
definitely feels that I can use window function to simplify the above, but have to switch to 
MS SQL Server or Oracle, because of the known issues of MySQL at Hackerrank site
already too late at night, will work on this later.

would be something that directly compute the count of count directly with window function, and the global max count
use where to filter out non-max and duplicated count-of-count >1
*/

