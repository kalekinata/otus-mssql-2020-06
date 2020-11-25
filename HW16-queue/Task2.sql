SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Sales.Invoces_Order
	@CustomerID INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @InitDlgHandle UNIQUEIDENTIFIER;
	DECLARE @RequestMessage NVARCHAR(4000);

	BEGIN TRAN
		
		SELECT @RequestMessage = (SELECT CustomerID
									FROM Sales.Invoices AS Inv
									WHERE CustomerID = @CustomerID
									FOR XML AUTO, ROOT('RequestMessage'));

		BEGIN DIALOG @InitDlgHandle
		FROM SERVICE
		[//WWI/SB/InitiatorService]
		TO SERVICE 
		'//WWI/SB/TargetService'
		ON CONTRACT
		[//WWI/SB/Contract]
		WITH ENCRYPTION=OFF;

		SEND ON CONVERSATION @InitDlgHandle
		MESSAGE TYPE 
		[//WWI/SB/RequestMessage]
		(@RequestMessage);

	COMMIT TRAN
END
GO

