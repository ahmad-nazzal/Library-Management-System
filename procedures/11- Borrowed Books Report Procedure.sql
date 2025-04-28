/*procedure Retrieve all books borrowed within the given range, with details like borrower name and borrowing date*/

drop procedure sp_BorrowedBooksReport
create procedure sp_BorrowedBooksReport
@StartDate DATE,
@EndDate DATE
as
begin
	select br.[first name], l.[date borrowed], b.title
	from borrowers br join loans l
	on br.borrowerid = l.borrowerid
	join books b on b.bookid = l.bookid
    WHERE l.[Date Borrowed] BETWEEN @StartDate AND @EndDate
end

EXEC sp_BorrowedBooksReport @StartDate = '2024-01-01', @EndDate = '2024-04-30';
