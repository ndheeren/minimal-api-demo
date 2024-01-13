CREATE PROCEDURE [dbo].[spUser_Insert]
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@Email nvarchar(50)
AS
begin
	insert into dbo.[User] (FirstName, LastName, Email)
	values (@FirstName, @LastName, @Email);
end
