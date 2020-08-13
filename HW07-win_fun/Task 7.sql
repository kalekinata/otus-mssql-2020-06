/* 7. �������� ������, ������� �������� 10 ��������, ������� ������� ������ 30 ������� � ��������� ����� ��� �� ������� ������ 2016.*/

SELECT TOP 10 I.CustomerID, C.CustomerName
FROM Sales.Invoices I
JOIN Sales.Customers C ON I.CustomerID = C.CustomerID
where 30 < (SELECT count(OrderID)
				FROM Sales.Invoices i
				WHERE I.InvoiceID = i.InvoiceID) 
AND (SELECT TOP 1 InvoiceDate
		FROM Sales.Invoices inv
		WHERE inv.CustomerID = I.CustomerID
		ORDER BY InvoiceDate DESC) >= '2016-04-01'