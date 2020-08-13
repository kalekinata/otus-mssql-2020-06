/*6. �������� �� ������� ������� 2 ����� ������� ������, ������� �� �������. � ����������� ������ ����:
- �� �������,
- ��� ��������,
- �� ������,
- ����,
- ���� �������. */

--������ � ������� ��������--
SELECT *
	FROM(
		SELECT i.CustomerID, c.CustomerName, si.StockItemName,
			 si.UnitPrice, i.InvoiceDate, 
			 ROW_NUMBER() OVER(PARTITION BY i.CustomerID ORDER BY si.UnitPrice DESC) AS num
		FROM Sales.InvoiceLines il
		JOIN Sales.Invoices i ON  il.InvoiceID = i.InvoiceID
		JOIN Sales.Customers c ON i.CustomerID = c.CustomerID
		JOIN Warehouse.StockItems si ON il.StockItemID = si.StockItemID
	) AS tab
WHERE num <= 2