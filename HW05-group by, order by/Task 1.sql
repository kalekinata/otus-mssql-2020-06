/*1. Посчитать среднюю цену товара, общую сумму продажи по месяцам

Вывести:
* Год продажи
* Месяц продажи
* Средняя цена за месяц по всем товарам
* Общая сумма продаж

Продажи смотреть в таблице Sales.Invoices и связанных таблицах.*/

SELECT DATEPART(year,InvoiceDate) as year,
	DATEPART(month,InvoiceDate) as month,
	AVG(s.UnitPrice) as avg,
	SUM(s.UnitPrice) as sum
FROM Sales.Invoices i
JOIN Sales.InvoiceLines il ON i.InvoiceID = il.InvoiceID
JOIN Warehouse.StockItems s ON il.StockItemID = s.StockItemID
GROUP BY DATEPART(year,InvoiceDate), DATEPART(month,InvoiceDate)
ORDER BY DATEPART(year,InvoiceDate), DATEPART(month,InvoiceDate)