/*3. ¬ывести список 2х самых попул€рных продуктов (по кол-ву проданных) в каждом мес€це за 2016й год (по 2 самых попул€рных продукта в каждом мес€це)*/

SELECT *
FROM
	(
		SELECT InvoiceDate, StockItemName, Quantity,
			ROW_NUMBER() OVER(PARTITION BY month(InvoiceDate) ORDER BY Quantity DESC, InvoiceDate) AS quan_num
		FROM Sales.Invoices i
			join Sales.InvoiceLines il on i.InvoiceID = il.InvoiceID
			join Warehouse.StockItems si on il.StockItemID = si.StockItemID
		where YEAR(InvoiceDate) = '2016'
	) AS tab
WHERE quan_num <= 2
ORDER BY InvoiceDate