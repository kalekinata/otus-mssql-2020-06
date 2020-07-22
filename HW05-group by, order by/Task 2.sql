/* 2. Отобразить все месяцы, где общая сумма продаж превысила 10 000

Вывести:
* Год продажи
* Месяц продажи
* Общая сумма продаж

Продажи смотреть в таблице Sales.Invoices и связанных таблицах.*/

SELECT DATEPART(year,InvoiceDate) as year,
	DATEPART(month,InvoiceDate) as month,
	SUM(il.UnitPrice) as sum
FROM Sales.Invoices i
JOIN Sales.InvoiceLines il ON i.InvoiceID = il.InvoiceID
GROUP BY DATEPART(year,InvoiceDate), DATEPART(month,InvoiceDate)
HAVING SUM(il.UnitPrice) > 10000
ORDER BY DATEPART(year,InvoiceDate), DATEPART(month,InvoiceDate)