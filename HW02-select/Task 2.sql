-2. Поставщиков (Suppliers), у которых не было сделано ни одного заказа (PurchaseOrders). Сделать через JOIN, с подзапросом задание принято не будет.
--Таблицы: Purchasing.Suppliers, Purchasing.PurchaseOrders.

-------------1 вариант---------
SELECT S.SupplierID, S.SupplierName
FROM Purchasing.Suppliers S
JOIN Purchasing.PurchaseOrders P ON S.SupplierID = P.SupplierID
GROUP BY S.SupplierID, S.SupplierName
HAVING COUNT(PurchaseOrderID) = 0

------------2 вариант----------
SELECT S.SupplierID, S.SupplierName
FROM Purchasing.Suppliers S
LEFT JOIN Purchasing.PurchaseOrders P ON S.SupplierID = P.SupplierID
WHERE S.SupplierID is null
