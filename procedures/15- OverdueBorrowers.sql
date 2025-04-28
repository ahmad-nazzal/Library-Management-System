/*Design a stored procedure that retrieves all borrowers who have overdue books. Store these borrowers in a temporary table, then join this temp table with the Loans table to list out the specific overdue books for each borrower.*/
drop procedure sp_StoreOverdueBorrowsToTempTable
CREATE PROCEDURE sp_StoreOverdueBorrowsToTempTable
AS
BEGIN

    CREATE TABLE #OverdueBorrowers (
        OverdueID INT IDENTITY(1,1) PRIMARY KEY,
        BorrowerID INT NOT NULL,
        LoanID INT NOT NULL
    );

    INSERT INTO #OverdueBorrowers (BorrowerID, LoanID)
    SELECT 
        BorrowerID, 
        LoanID
    FROM Loans
    WHERE [Due Date] < GETDATE();

    SELECT 
		b.BookID, b.Title, l.[Date Borrowed],
        o.BorrowerID,
        l.BookID,
        l.[Due Date],
		l.[date returned]
    FROM #OverdueBorrowers o
    JOIN Loans l ON o.LoanID = l.LoanID
	JOIN Books b on l.BookID = b.BookID

END;

EXEC sp_StoreOverdueBorrowsToTempTable;
