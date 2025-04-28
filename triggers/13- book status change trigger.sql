/*Design a trigger to log an entry into a separate AuditLog table whenever a book's status changes from 'Available' to 'Borrowed' or vice versa. The AuditLog should capture BookID, StatusChange, and ChangeDate.*/
CREATE TRIGGER trg_BookStatusChange
ON Books
AFTER UPDATE
AS
BEGIN

    INSERT INTO AuditLog (BookID, StatusChange, ChangeDate)
    SELECT
        inserted.BookID,
        CONCAT('Status changed from ', deleted.[Current Status], ' to ', inserted.[Current Status]),
        GETDATE()
    FROM inserted
    INNER JOIN deleted ON inserted.BookID = deleted.BookID
    WHERE inserted.[Current Status] <> deleted.[Current Status]
      AND inserted.[Current Status] IN ('Available', 'Borrowed')
      AND deleted.[Current Status] IN ('Available', 'Borrowed');
END;

UPDATE Books
SET [Current Status] = 'Borrowed'
WHERE BookID = 5;

select * from auditlog