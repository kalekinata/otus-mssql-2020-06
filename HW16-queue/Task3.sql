CREATE PROCEDURE Sales.NewInvoice_Order
AS
BEGIN
	
	DECLARE @TargetDlgHandle UNIQUEIDENTIFIER,
			@Message NVARCHAR(4000),
			@MessageType Sysname,
			@ReplyMessage NVARCHAR(4000),
			@CustomerID INT,
			@xml XML;

		BEGIN TRAN;
			RECEIVE TOP(1)
				@TargetDlgHandle = Conversation_Handle,
				@Message = Message_Body,
				@MessageType = Message_Type_Name
			FROM dbo.TargetQueueWWI;

			SELECT @Message;

			SET @xml = CAST(@Message AS XML);

			SELECT @CustomerID = R.Cust.value('@CustomerID','INT')
			FROM @xml.nodes('/RequestMessage/Inv') as R(Cust);

			IF EXISTS (SELECT * FROM Sales.Invoices WHERE CustomerID = @CustomerID)
				BEGIN
					INSERT INTO Customer_Orders
					SELECT i.CustomerID, COUNT(O.OrderID) AS Orders
					FROM Sales.Invoices i
					JOIN Sales.Orders o ON o.CustomerID = i.CustomerID
					WHERE i.CustomerID = @CustomerID AND InvoiceDate between '2013-01-01' and '2015-11-04'
					GROUP BY i.CustomerID
				END;
			SELECT @Message AS ReceivedRequestMessage, @MessageType;

			IF @MessageType=N'//WWI/SB/RequestMessage'
				BEGIN
					SET @ReplyMessage = N'<ReplyMessage> Message received</ReplyMessage>';

					SEND ON CONVERSATION @TargetDlgHandle
					MESSAGE TYPE
					[//WWI/SB/ReplyMessage]
					(@ReplyMessage);
					END CONVERSATION @TargetDlgHandle;
				END

			SELECT @ReplyMessage AS SentReplyMessage;

			COMMIT TRAN;
END