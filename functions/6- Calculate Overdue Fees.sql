/*
 Charge fees based on overdue days: $1/day for up to 30 days, $2/day after.
*/
CREATE FUNCTION fn_CalculateOverdueFees (@LoanID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @OverdueDays INT;
    DECLARE @DueDate DATE;
    DECLARE @ReturnDate DATE;
    DECLARE @OverdueFee DECIMAL(10, 2);

    SELECT @DueDate = DueDate, @ReturnDate = DateReturned
    FROM Loans
    WHERE LoanID = @LoanID;

    IF @ReturnDate IS NULL
    BEGIN
        SET @ReturnDate = GETDATE();
    END

    SET @OverdueDays = DATEDIFF(DAY, @DueDate, @ReturnDate);

    IF @OverdueDays > 0
    BEGIN
        IF @OverdueDays <= 30
        BEGIN
            SET @OverdueFee = @OverdueDays * 1.00; -- $1/day
        END
        ELSE
        BEGIN
            SET @OverdueFee = (30 * 1.00) + ((@OverdueDays - 30) * 2.00);
        END
    END
    ELSE
    BEGIN
        SET @OverdueFee = 0;
    END

    RETURN @OverdueFee;
END;