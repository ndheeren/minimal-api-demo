if not exists (select 1 from dbo.[User])
begin
	insert into dbo.[User] (FirstName, LastName, Email)
	values
	('Adam', 'Ackman', 'aackman@foomail.com'),
	('Bill', 'Burr', 'bburr@foomail.com'),
	('Charles', 'Chapman', 'cchapman@foomail.com'),
	('Deborah', 'Dohen', 'ddohen@foomail.com');
end
GO
