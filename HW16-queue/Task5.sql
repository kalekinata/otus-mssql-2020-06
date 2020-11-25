use WideWorldImporters;

select *
From dbo.Customer_Orders
where CustomerID = 5;

EXEC Sales.Invoces_Order
		@CustomerID = 5;


select cast(message_body AS XML), *
FROM dbo.InitiatorQueueWWI;

select cast(message_body AS XML), *
FROM dbo.TargetQueueWWI;

EXEC Sales.NewInvoice_Order;

EXEC Sales.Customer_Invoices;


SELECT conversation_handle, is_initiator, s.name as 'local service',
far_service, sc.name 'contract', ce.state_desc
FROM sys.conversation_endpoints ce
LEFT JOIN sys.services s ON ce.service_id = s.service_id
LEFT JOIN sys.service_contracts sc ON ce.service_contract_id = sc.service_contract_id
ORDER BY conversation_handle;