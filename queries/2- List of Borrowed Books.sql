/* List of Borrowed Books: Retrieve all books borrowed by a specific borrower, including those currently unreturned.*/

with ActiveBorrowersWithoutReturns as (
select borrowerid, count(*) as [borrowerd books count]
from loans
where loans.[date returned] is null
group by borrowerid
)
select borrowers.borrowerid,
		borrowers.[first name],
		borrowers.[last name],
		[borrowerd books count]
from ActiveBorrowersWithoutReturns
join borrowers on borrowers.borrowerid = ActiveBorrowersWithoutReturns.borrowerid
where ActiveBorrowersWithoutReturns.[borrowerd books count] >= 2
