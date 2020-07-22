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

SELECT DATEPART(year,InvoiceDate) as year,
	DATEPART(month,InvoiceDate) as month,
	StockItemName,
	SUM(s.UnitPrice) as sum,
	COUNT(StockItemName) as kolvo
FROM Sales.Invoices i
JOIN Sales.InvoiceLines il ON i.InvoiceID = il.InvoiceID
JOIN Warehouse.StockItems s ON il.StockItemID = s.StockItemID
GROUP BY DATEPART(year,InvoiceDate), DATEPART(month,InvoiceDate),StockItemName
HAVING COUNT(StockItemName) < 50
ORDER BY DATEPART(year,InvoiceDate), DATEPART(month,InvoiceDate)