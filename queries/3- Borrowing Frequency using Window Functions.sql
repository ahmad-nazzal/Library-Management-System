/*Borrowing Frequency using Window Functions: Rank borrowers based on borrowing frequency.*/
select borrowerid, dense_rank() over(order by count(borrowerid)) as borrowingFrequenctRank
from loans
group by borrowerid