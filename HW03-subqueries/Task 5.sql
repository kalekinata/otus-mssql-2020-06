/*5. Объясните, что делает и оптимизируйте запрос:
SELECT
	Invoices.InvoiceID,
	Invoices.InvoiceDate,
	(SELECT People.FullName
		FROM Application.People
		WHERE People.PersonID = Invoices.SalespersonPersonID) AS SalesPersonName,
	SalesTotals.TotalSumm AS TotalSummByInvoice,
	(SELECT SUM(OrderLines.PickedQuantity*OrderLines.UnitPrice)
		FROM Sales.OrderLines
		WHERE OrderLines.OrderId = (SELECT Orders.OrderId
									FROM Sales.Orders
									WHERE Orders.PickingCompletedWhen IS NOT NULL
									AND Orders.OrderId = Invoices.OrderId)) AS TotalSummForPickedItems
FROM Sales.Invoices
JOIN(SELECT InvoiceId, SUM(Quantity*UnitPrice) AS TotalSumm
		FROM Sales.InvoiceLines
		GROUP BY InvoiceId
		HAVING SUM(Quantity*UnitPrice) > 27000) AS SalesTotals
		ON Invoices.InvoiceID = SalesTotals.InvoiceID
		ORDER BY TotalSumm DESC
Можно двигаться как в сторону улучшения читабельности запроса, так и в сторону упрощения плана\ускорения. Сравнить производительность запросов можно через SET STATISTICS IO, TIME ON. Если знакомы с планами запросов, то используйте их (тогда к решению также приложите планы). Напишите ваши рассуждения по поводу оптимизации.*/

SELECT Invoices.InvoiceID,Invoices.InvoiceDate,People.FullName AS SalesPersonName, SalesTotals.TotalSumm AS TotalSummByInvoice,
	(SELECT SUM(OrderLines.PickedQuantity*OrderLines.UnitPrice)
		FROM Sales.OrderLines
		INNER HASH JOIN Sales.Orders ON OrderLines.OrderID = Orders.OrderID
		WHERE Orders.OrderId = Invoices.OrderId and Orders.PickingCompletedWhen IS NOT NULL) AS TotalSummForPickedItems
FROM Sales.Invoices
JOIN Application.People ON  People.PersonID = Invoices.SalespersonPersonID
JOIN (SELECT InvoiceId, SUM(Quantity*UnitPrice) AS TotalSumm
		FROM Sales.InvoiceLines
		GROUP BY InvoiceId
		HAVING SUM(Quantity*UnitPrice) > 27000) AS SalesTotals ON Invoices.InvoiceID = SalesTotals.InvoiceID
ORDER BY TotalSumm DESC

Необходимо выбрать id счёта, дату составления счёта, имя продавца, который является продажником, оформляющим счета. Также вывести общую сумму оформленного заказа, которая больше 27000, и общую цену упакованного товара при завершении комплектации заказа. Информация выводится в порядке убывания общей суммы заказа.