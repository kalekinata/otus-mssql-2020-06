/* 3. Вывести сумму продаж, дату первой продажи и количество проданного по месяцам, по товарам, продажи которых менее 50 ед в месяц.
Группировка должна быть по году, месяцу, товару.

Вывести:
* Год продажи
* Месяц продажи
* Наименование товара
* Сумма продаж
* Дата первой продажи
* Количество проданного

Продажи смотреть в таблице Sales.Invoices и связанных таблицах.*/

SELECT DATEPART(year,i.InvoiceDate) as year,
	DATEPART(month,i.InvoiceDate) as month,
	StockItemName,
	SUM(s.UnitPrice) as sum,
	COUNT(s.StockItemName) as kolvo
FROM Sales.Invoices i
JOIN Sales.InvoiceLines il ON i.InvoiceID = il.InvoiceID
JOIN Warehouse.StockItems s ON il.StockItemID = s.StockItemID
WHERE il.Quantity < 50
GROUP BY DATEPART(year,i.InvoiceDate), DATEPART(month,i.InvoiceDate),s.StockItemName
ORDER BY DATEPART(year,i.InvoiceDate), DATEPART(month,i.InvoiceDate)