/*3. Вывести список 2х самых популярных продуктов (по кол-ву проданных) в каждом месяце за 2016й год (по 2 самых популярных продукта в каждом месяце)*/

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
