/*5. По каждому сотруднику выведите последнего клиента, которому сотрудник что-то продал. В результатах должны быть:
  - ид и фамилия сотрудника,
  - ид и название клиента,
  - дата продажи,
  - сумму сделки. */

--запрос с оконной функцией--
SELECT s.SupplierID, s.SupplierName,
LAST_VALUE(c.CustomerID) OVER(order by s.SupplierID), 
c.CustomerName, i.InvoiceDate, 
SUM(il.UnitPrice) OVER(ORDER BY i.InvoiceID) AS Price
FROM Warehouse.StockItemTransactions sit 
JOIN Sales.Customers c ON sit.CustomerID = c.CustomerID
JOIN Sales.Invoices i ON sit.InvoiceID = i.InvoiceID
JOIN Sales.InvoiceLines il ON i.InvoiceID = il.InvoiceID
JOIN Purchasing.Suppliers s ON sit.SupplierID = s.SupplierID

--запрос с подзапросом--
SELECT s.SupplierID, s.SupplierName,
	(SELECT TOP 1 CustomerID 
		FROM Warehouse.StockItemTransactions si
		WHERE InvoiceID = i.InvoiceID AND si.StockItemTransactionID = sit. StockItemTransactionID
		ORDER BY InvoiceID DESC),
	c.CustomerName,	 i.InvoiceDate,
	(SELECT SUM(Inv.UnitPrice)
		FROM Sales.InvoiceLines Inv
		WHERE Inv.InvoiceLineID = il.InvoiceLineID) AS Price
FROM Warehouse.StockItemTransactions sit 
JOIN Sales.Customers c ON sit.CustomerID = c.CustomerID
JOIN Sales.Invoices i ON sit.InvoiceID = i.InvoiceID
JOIN Sales.InvoiceLines il ON i.InvoiceID = il.InvoiceID
JOIN Purchasing.Suppliers s ON sit.SupplierID = s.SupplierID