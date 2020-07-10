--2. ����������� (Suppliers), � ������� �� ���� ������� �� ������ ������ (PurchaseOrders). ������� ����� JOIN, � ����������� ������� ������� �� �����.
--�������: Purchasing.Suppliers, Purchasing.PurchaseOrders.

-------------1 �������---------
SELECT S.SupplierID, S.SupplierName
FROM Purchasing.Suppliers S
JOIN Purchasing.PurchaseOrders P ON S.SupplierID = P.SupplierID
GROUP BY S.SupplierID, S.SupplierName
HAVING COUNT(PurchaseOrderID) = 0

------------2 �������----------
SELECT S.SupplierID, S.SupplierName
FROM Purchasing.Suppliers S
LEFT JOIN Purchasing.PurchaseOrders P ON S.SupplierID = P.SupplierID
WHERE S.SupplierID is null