/* 4. ���������� �� �� ������� ������� ����� CROSS APPLY
�������� �� ������� ������� 2 ����� ������� ������, ������� �� �������
� ����������� ������ ���� �� ������, ��� ��������, �� ������, ����, ���� �������. */

SELECT c.CustomerID,c.CustomerName, i.StockItemName, i.UnitPrice,i.InvoiceDate
FROM Sales.Customers c
CROSS APPLY (SELECT TOP 2 si.StockItemName,si.StockItemID,
			 si.UnitPrice, i.InvoiceDate
			 FROM Sales.Invoices i
			 JOIN Sales.InvoiceLines il ON i.InvoiceID = il.InvoiceID
			 JOIN Warehouse.StockItems si ON  il.StockItemID = si.StockItemID
			 WHERE il.StockItemID = si.StockItemID and i.CustomerID = c.CustomerID
			 ORDER BY si.UnitPrice desc) as i
ORDER BY CustomerID, i.InvoiceDate