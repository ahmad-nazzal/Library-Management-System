/* Check if an email exists; if not, add to Borrowers. If existing, return an error message.*/

drop procedure if exists sp_AddNewBorrower;

create procedure sp_AddNewBorrower (
	@FirstName varchar(25),
	@LastName varchar(25),
	@Email varchar(50),
	@DateOfBirth Date,
	@MembershipDate Date
)
as
begin
	if exists (select * from borrowers where email = @Email)
	begin
		throw 50001, 'Email Already Existd', 1;
		return;
	end

	INSERT INTO Borrowers VALUES (@FirstName, @LastName, @Email, @DateOfBirth, @MembershipDate);
	SELECT SCOPE_IDENTITY() AS NewBorrowerID;
end


EXEC sp_AddNewBorrower 
    @FirstName = 'John',
    @LastName = 'Doe',
    @Email = 'john.doe1@example.com',
    @DateOfBirth = '1990-06-15',
    @MembershipDate = '2025-04-27';