CREATE TABLE [Books] (
  [BookID] INT IDENTITY(1,1) PRIMARY KEY,
  [Title] VARCHAR(50) NOT NULL,
  [Author] VARCHAR(50) NOT NULL,
  [ISBN] VARCHAR(20) NOT NULL UNIQUE,
  [Published Date] DATE NOT NULL,
  [Genre] VARCHAR(50) NOT NULL,
  [Shelf Location] VARCHAR(50) NOT NULL,
  [Current Status] VARCHAR(10) CHECK ([Current Status] IN ('Available', 'Borrowed')) NOT NULL DEFAULT 'Available'
  
);

CREATE TABLE [Borrowers] (
  [BorrowerID] INT IDENTITY(1,1) PRIMARY KEY,
  [First Name] VARCHAR(25) NOT NULL,
  [Last Name] VARCHAR(25) NOT NULL,
  [Email] VARCHAR(50) NOT NULL UNIQUE,
  [Date of Birth] DATE NOT NULL,
  [Membership Date] DATE NOT NULL
);

CREATE TABLE [Loans] (
  [LoanID] INT IDENTITY(1,1) PRIMARY KEY,
  [BookID] INT NOT NULL,
  [BorrowerID] INT NOT NULL,
  [Date Borrowed] DATE NOT NULL,
  [Due Date] DATE NOT NULL,
  [Date Returned] DATE,
  CONSTRAINT [FK_Loans.BookID]
    FOREIGN KEY ([BookID]) REFERENCES [Books]([BookID]),
  CONSTRAINT [FK_Loans.BorrowerID]
    FOREIGN KEY ([BorrowerID]) REFERENCES [Borrowers]([BorrowerID])
);