CREATE PROCEDURE Sales.Customer_Invoices
AS
BEGIN
	
	DECLARE @InitiatorReplyDlgHandle UNIQUEIDENTIFIER,
			@ReplyReceivedMessange NVARCHAR(1000)

	BEGIN TRAN;
		
		RECEIVE TOP(1)
			@InitiatorReplyDlgHandle=Conversation_Handle,
			@ReplyReceivedMessange=Message_Body
		FROM dbo.InitiatorQueueWWI;

		END CONVERSATION @InitiatorReplyDlgHandle;


		SELECT @ReplyReceivedMessange AS RecivedReplyReceivedMessange;

	COMMIT TRAN;

END