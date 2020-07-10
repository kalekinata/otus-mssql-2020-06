--4. ������ ����������� (Purchasing.Suppliers), ������� ���� ��������� � ������ 2014 ���� � ��������� Air Freight ��� Refrigerated Air Freight (DeliveryMethodName).
--�������:
--* ������ �������� (DeliveryMethodName)
--* ���� ��������
--* ��� ����������
--* ��� ����������� ���� ������������ ����� (ContactPerson)

--�������: Purchasing.Suppliers, Purchasing.PurchaseOrders, Application.DeliveryMethods, Application.People.

SELECT  DeliveryMethodName,CONVERT(VarChar, OrderDate, 104), SupplierName, FullName
FROM Purchasing.PurchaseOrders p 
JOIN Application.DeliveryMethods d ON p.DeliveryMethodID = d.DeliveryMethodID
JOIN Purchasing.Suppliers s ON p.SupplierID = s.SupplierID
JOIN Application.People pl ON p.ContactPersonID = pl.PersonID
WHERE (OrderDate BETWEEN '01.01.2014' AND '31.01.2014') AND (DeliveryMethodName = 'Air Freight' OR DeliveryMethodName = 'Refrigerated Air Freight')