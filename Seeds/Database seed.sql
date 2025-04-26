-- Insert 1000 Books
DECLARE @i INT = 1;

WHILE @i <= 1000
BEGIN
    INSERT INTO Books ([Title], [Author], [ISBN], [Published Date], [Genre], [Shelf Location], [Current Status])
    VALUES (
        CONCAT('Book Title ', @i),
        CONCAT('Author ', @i),
        CONCAT('ISBN', FORMAT(@i, '0000000000')),
        DATEADD(DAY, -@i, GETDATE()),
        CASE 
            WHEN @i % 5 = 0 THEN 'Science'
            WHEN @i % 5 = 1 THEN 'Fiction'
            WHEN @i % 5 = 2 THEN 'History'
            WHEN @i % 5 = 3 THEN 'Biography'
            ELSE 'Technology'
        END,
        CONCAT('Shelf ', CHAR(65 + (@i % 26))),
        'Available'
    );
    SET @i += 1;
END;

-- Insert 1000 Borrowers
SET @i = 1;
WHILE @i <= 1000
BEGIN
    INSERT INTO Borrowers ([First Name], [Last Name], [Email], [Date of Birth], [Membership Date])
    VALUES (
        CONCAT('FirstName', @i),
        CONCAT('LastName', @i),
        CONCAT('borrower', @i, '@library.com'),
        DATEADD(YEAR, -18 - (@i % 30), GETDATE()),
        DATEADD(DAY, -@i, GETDATE())
    );
    SET @i += 1;
END;



-- Insert 1000 Loans
SET @i = 1;
WHILE @i <= 1000
BEGIN
    DECLARE @bookId INT = (SELECT TOP 1 BookID FROM Books ORDER BY NEWID());
    DECLARE @borrowerId INT = (SELECT TOP 1 BorrowerID FROM Borrowers ORDER BY NEWID());
    DECLARE @borrowedDate DATE = DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 365), GETDATE());
    DECLARE @dueDate DATE = DATEADD(DAY, 14, @borrowedDate);
    DECLARE @dateReturned DATE = CASE 
        WHEN (@i % 7 = 0) THEN NULL -- Some loans are still active
        ELSE DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 20), @borrowedDate)
    END;

    INSERT INTO Loans ([BookID], [BorrowerID], [Date Borrowed], [Due Date], [Date Returned])
    VALUES (
        @bookId,
        @borrowerId,
        @borrowedDate,
        @dueDate,
        @dateReturned
    );
    SET @i += 1;
END;



-- Update book status to 'Borrowed' for books currently loaned (not yet returned)
UPDATE Books
SET [Current Status] = 'Borrowed'
WHERE BookID IN (
    SELECT BookID FROM Loans WHERE [Date Returned] IS NULL
);