/*Author Popularity using Aggregation: Rank authors by the borrowing frequency of their books.
*/
select b.author, count(b.bookid) numberOfBorrowerd, DENSE_RANK() over(order by count(b.bookid) desc) authorRank   from 
books b join loans l
on b.bookid = l.bookid
group by b.author
order by numberOfBorrowerd desc