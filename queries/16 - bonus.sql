/*Weekly peak days: The library is planning to employ a new part-time worker. This worker will work 3 days weekly in the library. From the data you have, determine the most 3 days in the week that have the most share of the loans and display the result of each day as a percentage of all loans. Sort the results from the highest percentage to the lowest percentage. (eg. 25.18% of the loans happen on Monday...)*/
WITH BorrowCounts AS
(
	SELECT DATENAME(DW, [Date Borrowed]) as dayOfWeek,
	COUNT(*) as borrowsCount
	FROM Loans
	GROUP BY DATENAME(DW, [Date Borrowed])
),
TotalBorrows AS
(
	SELECT SUM (borrowsCount) as Total
	FROM BorrowCounts
)
select top(3) *, ROUND((CAST(bc.borrowsCount AS FLOAT) / tb.Total) * 100, 2) AS LoanPercentage
 from BorrowCounts bc
CROSS JOIN TotalBorrows tb
order by borrowsCount desc