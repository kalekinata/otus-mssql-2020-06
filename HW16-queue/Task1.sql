USE master
GO
ALTER DATABASE WideWorldImporters SET SINGLE_USER WITH ROLLBACK IMMEDIATE

USE master
ALTER DATABASE WideWorldImporters
SET ENABLE_BROKER;

ALTER DATABASE WideWorldImporters SET TRUSTWORTHY ON

select DATABASEPROPERTYEX('WideWorldImporters','UserAccess');
select is_broker_enabled from sys.databases where name = 'WideWorldImporters'

ALTER AUTHORIZATION 
	ON DATABASE:: WideWorldImporters TO [sa];

ALTER DATABASE WideWorldImporters SET MULTI_USER WITH ROLLBACK IMMEDIATE
GO

CREATE MESSAGE TYPE
[//WWI/SB/RequestMessage]
VALIDATION=WELL_FORMED_XML;

CREATE MESSAGE TYPE [//WWI/SB/ReplyMessage]
VALIDATION=WELL_FORMED_XML;

GO 

CREATE CONTRACT [//WWI/SB/Contract]
		([//WWI/SB/RequestMessage]
			SENT BY INITIATOR,
		 [//WWI/SB/ReplyMessage]
			SENT BY TARGET
		);
GO

CREATE QUEUE TargetQueueWWI;

CREATE SERVICE [//WWI/SB/TargetService]
	   ON QUEUE TargetQueueWWI
	   ([//WWI/SB/Contract]);
GO

CREATE QUEUE InitiatorQueueWWI;

CREATE SERVICE [//WWI/SB/InitiatorService]
	   ON QUEUE InitiatorQueueWWI
	   ([//WWI/SB/Contract]);
GO


use WideWorldImporters
Create table Customer_Orders
(
	CustomerID int,
	Orders int
);



