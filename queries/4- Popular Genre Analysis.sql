/*Popular Genre Analysis using Joins and Window Functions: Identify the most popular genre for a given month.*/
with genreRank as (
select b.genre, count(*) as frequency,dense_rank() over (order by count(*) desc) as [most popular]
from loans l
join books b
on l.bookid = b.bookid
where month(l.[date borrowed]) = 2
group by b.genre
)
select genre, frequency, [most popular] from genreRank where [most popular] =1