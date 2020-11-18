exec sp_configure 'show advanced options', 1;
go
reconfigure;
go


exec sp_configure 'clr enabled', 1;
exec sp_configure 'clr strict security', 0
go
reconfigure;
go

alter database station_train set trustworthy on;

create assembly SplitString
from 'C:\ClassLibrary1\bin\Debug\ClassLibrary1.dll'
with permission_set = safe;


CREATE FUNCTION [dbo].SplitStringCLR(@text [nvarchar](max), @delimiter [nchar](1))
RETURNS TABLE (
part nvarchar(max),
ID_ODER int
) WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [SplitString].[ClassLibrary1.UserDefinedFunctions].[SplitString]