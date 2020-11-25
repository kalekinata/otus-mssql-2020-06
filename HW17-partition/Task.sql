/*Секционирование таблицы
Выбираем в своем проекте таблицу-кандидат для секционирования и добавляем партиционирование.
Если в проекте нет такой таблицы, то делаем анализ базы данных из первого модуля, выбираем 
таблицу и делаем ее секционирование, с переносом данных по секциям (партициям) - исходя из
того, что таблица большая, пишем скрипты миграции в секционированную таблицу*/

use WideWorldImporters

select distinct t.name
from sys.partitions p
inner join sys.tables t on p.object_id = t.object_id
where p.partition_number <> 1


ALTER DATABASE [WideWorldImporters] ADD FILEGROUP [YearOrders]
GO

ALTER DATABASE [WideWorldImporters] ADD FILE
(NAME = N'Years', FILENAME = N'C:\1\Years.ndf',
SIZE = 1097152KB, FILEGROWTH = 65536KB) TO FILEGROUP [YearOrders]

CREATE PARTITION FUNCTION [fnPartition](DATE) AS RANGE RIGHT FOR VALUES
('2012-01-01','2013-01-01','2014-01-01','2015-01-01','2016-01-01','2017-01-01','2018-01-01','2019-01-01','2020-01-01','2021-01-01');

CREATE PARTITION SCHEME [schmYearPartition] AS PARTITION [fnPartition]
ALL TO ([YearOrders])
GO


CREATE TABLE [Sales].[OrdersYears](
	   [OrderID] INT NOT NULL,
	   [CustomerID] INT,
	   [SalespersonPersonID] INT,
	   [ContactPersonID] INT,
	   [BackorderOrderID] INT,
	   [OrderDate] DATE NOT NULL,
	   [ExpectedDeliveryDate] DATE,
	   [CustomerPurchaseOrderNumber] NVARCHAR(20),
	   [IsUndersupplyBackordered] BIT,
	   [Comments] NVARCHAR(MAX),
	   [DeliveryInstructions] NVARCHAR(MAX),
	   [InternalComments] NVARCHAR(MAX),
	   [PickingCompletedWhen] DATETIME2(7),
	   [LastEditedBy] INT,
	   [LastEditedWhen] DATETIME2(7),
)	ON [schmYearPartition]([OrderDate])
GO

ALTER TABLE [Sales].[OrdersYears] ADD CONSTRAINT PK_Sales_OrdersYears
PRIMARY KEY CLUSTERED (OrderID,OrderDate)
ON [schmYearPartition]([OrderDate]);

INSERT INTO [Sales].[OrdersYears](OrderID, CustomerID,SalespersonPersonID, ContactPersonID, BackorderOrderID, OrderDate, ExpectedDeliveryDate, IsUndersupplyBackordered, LastEditedBy, LastEditedWhen)
SELECT [OrderID], [CustomerID],[SalespersonPersonID], [ContactPersonID], [BackorderOrderID], [OrderDate], [ExpectedDeliveryDate], [IsUndersupplyBackordered], [LastEditedBy], [LastEditedWhen] FROM [Sales].[Orders]

