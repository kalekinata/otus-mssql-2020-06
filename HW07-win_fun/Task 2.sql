/*2. Если вы брали предложенный выше запрос, то сделайте расчет суммы нарастающим итогом с помощью оконной функции.
Сравните 2 варианта запроса - через windows function и без них. Написать какой быстрее выполняется, сравнить по set statistics time on;. */

set statistics time on;

--запрос с оконной функцией--
SELECT DISTINCT i.InvoiceID,
				c.CustomerName,
				i.InvoiceDate,
				(SUM(il.UnitPrice) OVER(ORDER BY MONTH(InvoiceDate))) as Progressive_Total
FROM Sales.Invoices i
	JOIN Sales.InvoiceLines il ON il.InvoiceID = i.InvoiceID
	JOIN Sales.Customers c ON i.CustomerID = c.CustomerID
WHERE InvoiceDate >= '2015.01.01'
ORDER BY InvoiceID;

--запрос с подзапросом--
SELECT distinct i.InvoiceID,
				c.CustomerName,
				i.InvoiceDate,
				(SELECT SUM(il.UnitPrice)
					FROM Sales.Invoices i1
						JOIN Sales.InvoiceLines il ON i1.InvoiceID = il.InvoiceID
					WHERE MONTH(i1.InvoiceDate) = MONTH(i.InvoiceDate) and InvoiceDate >= '2015.01.01'
					GROUP BY MONTH(i1.InvoiceDate)
				) as Progressive_Total
FROM Sales.Invoices i
	JOIN Sales.Customers c ON i.CustomerID = c.CustomerID
WHERE InvoiceDate >= '2015.01.01'
ORDER BY InvoiceID;

--Запрос с оконной функцией выполняется быстрее, чем запрос с подзапросом.
--При выполнении запроса с оконной функцией время ЦП = 245 мс, истекшее время = 245 мс, а при выполнении запроса с подзапросом ремя ЦП = 625 мс, затраченное время = 1575 мс.--
