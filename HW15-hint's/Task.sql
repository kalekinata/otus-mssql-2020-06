set statistics io, time  on;

Select ord.CustomerID, det.StockItemID, SUM(det.UnitPrice), SUM(det.Quantity), COUNT(ord.OrderID)
FROM Sales.Orders AS ord
INNER MERGE JOIN Sales.OrderLines AS det
ON det.OrderID = ord.OrderID
INNER MERGE JOIN Sales.Invoices AS Inv
ON Inv.OrderID = ord.OrderID
INNER MERGE JOIN Sales.CustomerTransactions AS Trans
ON Trans.InvoiceID = Inv.InvoiceID
INNER MERGE JOIN Warehouse.StockItemTransactions AS ItemTrans
ON ItemTrans.StockItemID = det.StockItemID
WHERE Inv.BillToCustomerID != ord.CustomerID
AND (Select SupplierId
FROM Warehouse.StockItems AS It
Where It.StockItemID = det.StockItemID) = 12
AND (SELECT SUM(Total.UnitPrice*Total.Quantity)
FROM Sales.OrderLines AS Total
INNER MERGE JOIN Sales.Orders AS ordTotal
On ordTotal.OrderID = Total.OrderID
WHERE ordTotal.CustomerID = Inv.CustomerID) > 250000
AND DATEDIFF(dd, Inv.InvoiceDate, ord.OrderDate) = 0
GROUP BY ord.CustomerID, det.StockItemID
ORDER BY ord.CustomerID, det.StockItemID
option(maxdop 1)

/*����� ��������������� ������� � ���������� SQL Server: 
 ����� �� = 0 ��, �������� ����� = 0 ��.

 ����� ������ SQL Server:
   ����� �� = 0 ��, ����������� ����� = 0 ��.

 ����� ������ SQL Server:
   ����� �� = 0 ��, ����������� ����� = 0 ��.
��������! ������� ������� ���������� ��� ������ �������������, ��������� �������������� �������� ���������� ����������.
����� ��������������� ������� � ���������� SQL Server: 
 ����� �� = 24 ��, �������� ����� = 24 ��.

 ����� ������ SQL Server:
   ����� �� = 0 ��, ����������� ����� = 0 ��.

(��������� �����: 3619)
������� "OrderLines". ����� ���������� 4, ���������� ������ 0, ���������� ������ 0, ����������� ������ 0, lob ���������� ������ 331, lob ���������� ������ 0, lob ����������� ������ 0.
������� "OrderLines". ������� ��������� 2, ��������� 0.
������� "Worktable". ����� ���������� 15, ���������� ������ 62132, ���������� ������ 0, ����������� ������ 0, lob ���������� ������ 0, lob ���������� ������ 0, lob ����������� ������ 0.
������� "StockItemTransactions". ����� ���������� 1, ���������� ������ 60, ���������� ������ 0, ����������� ������ 0, lob ���������� ������ 0, lob ���������� ������ 0, lob ����������� ������ 0.
������� "CustomerTransactions". ����� ���������� 5, ���������� ������ 261, ���������� ������ 0, ����������� ������ 0, lob ���������� ������ 0, lob ���������� ������ 0, lob ����������� ������ 0.
������� "Orders". ����� ���������� 2, ���������� ������ 1384, ���������� ������ 0, ����������� ������ 0, lob ���������� ������ 0, lob ���������� ������ 0, lob ����������� ������ 0.
������� "Invoices". ����� ���������� 1, ���������� ������ 11400, ���������� ������ 0, ����������� ������ 0, lob ���������� ������ 0, lob ���������� ������ 0, lob ����������� ������ 0.
������� "StockItems". ����� ���������� 1, ���������� ������ 2, ���������� ������ 0, ����������� ������ 0, lob ���������� ������ 0, lob ���������� ������ 0, lob ����������� ������ 0.

(��������� �����: 31)

(��������� ���� ������)

 ����� ������ SQL Server:
   ����� �� = 2313 ��, ����������� ����� = 2398 ��.
����� ��������������� ������� � ���������� SQL Server: 
 ����� �� = 0 ��, �������� ����� = 0 ��.

 ����� ������ SQL Server:
   ����� �� = 0 ��, ����������� ����� = 0 ��.

 ����� ������ SQL Server:
   ����� �� = 0 ��, ����������� ����� = 0 ��.*/


