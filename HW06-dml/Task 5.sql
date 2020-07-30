/* 5. Напишите запрос, который выгрузит данные через bcp out и загрузить через bulk insert. */

exec master..xp_cmdshell 'bcp "[WideWorldImporters].Sales.Customers" out  "C:\1\Customers.txt" -T -w -t" | " -S LAPTOP-BUUJP2NU\SQL2017'

BULK INSERT [WideWorldImporters].[Sales].[Customers_Demo]
		   FROM "C:\1\Customers.txt"
		   WITH 
			 (
				BATCHSIZE = 1000, 
				DATAFILETYPE = 'widechar',
				FIELDTERMINATOR = ' | ',
				ROWTERMINATOR ='\n',
				KEEPNULLS,
				TABLOCK        
			 );