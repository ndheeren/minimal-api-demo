﻿/*
Deployment script for MinimalApiUserDb

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "MinimalApiUserDb"
:setvar DefaultFilePrefix "MinimalApiUserDb"
:setvar DefaultDataPath "C:\Users\Apthorpe\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\Apthorpe\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Altering Table [dbo].[User]...';


GO
ALTER TABLE [dbo].[User] ALTER COLUMN [Email] NVARCHAR (50) NULL;

ALTER TABLE [dbo].[User] ALTER COLUMN [FirstName] NVARCHAR (50) NOT NULL;

ALTER TABLE [dbo].[User] ALTER COLUMN [LastName] NVARCHAR (50) NOT NULL;


GO
PRINT N'Refreshing Procedure [dbo].[spUser_Delete]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spUser_Delete]';


GO
PRINT N'Refreshing Procedure [dbo].[spUser_Get]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spUser_Get]';


GO
PRINT N'Refreshing Procedure [dbo].[spUser_GetAll]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spUser_GetAll]';


GO
PRINT N'Refreshing Procedure [dbo].[spUser_Insert]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spUser_Insert]';


GO
PRINT N'Refreshing Procedure [dbo].[spUser_Update]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[spUser_Update]';


GO
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

GO
PRINT N'Update complete.';


GO