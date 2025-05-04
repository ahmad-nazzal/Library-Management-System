CREATE UNIQUE INDEX IX_Books_ISBN ON Books(ISBN);
CREATE INDEX IX_Books_CurrentStatus ON Books([Current Status]);
CREATE INDEX IX_Books_Genre ON Books(Genre);
CREATE INDEX IX_Books_Author ON Books(Author);

CREATE UNIQUE INDEX IX_Borrowers_Email ON Borrowers(Email);
CREATE INDEX IX_Borrowers_BorrowerID ON Borrowers(BorrowerID);
CREATE INDEX IX_Borrowers_DateOfBirth ON Borrowers([Date of Birth]);

CREATE INDEX IX_Loans_BookID ON Loans(BookID);
CREATE INDEX IX_Loans_BorrowerID ON Loans(BorrowerID);
CREATE INDEX IX_Loans_StatusCheck ON Loans([Date Returned], [Due Date]);
CREATE INDEX IX_Loans_DateBorrowed ON Loans([Date Borrowed]);
CREATE INDEX IX_Loans_LoanID_BookID ON Loans(BookID, LoanID);
