/*List all books overdue by more than 30 days with their associated borrowers*/
select * from books b
join loans l
on l.bookid = b.bookid
where DATEDIFF(DAY, l.[due date], l.[date returned]) > 30