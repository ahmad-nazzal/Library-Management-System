select * from books
join loans on loans.bookID = books.bookID
where loans.borrowerid = 569