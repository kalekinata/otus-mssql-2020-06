--4. Заказы поставщикам (Purchasing.Suppliers), которые были исполнены в январе 2014 года с доставкой Air Freight или Refrigerated Air Freight (DeliveryMethodName).
--Вывести:
--* способ доставки (DeliveryMethodName)
--* дата доставки
--* имя поставщика
--* имя контактного лица принимавшего заказ (ContactPerson)

--Таблицы: Purchasing.Suppliers, Purchasing.PurchaseOrders, Application.DeliveryMethods, Application.People.

SELECT  DeliveryMethodName,CONVERT(VarChar, OrderDate, 104), SupplierName, FullName
FROM Purchasing.PurchaseOrders p 
JOIN Application.DeliveryMethods d ON p.DeliveryMethodID = d.DeliveryMethodID
JOIN Purchasing.Suppliers s ON p.SupplierID = s.SupplierID
JOIN Application.People pl ON p.ContactPersonID = pl.PersonID
WHERE (OrderDate BETWEEN '01.01.2014' AND '31.01.2014') AND (DeliveryMethodName = 'Air Freight' OR DeliveryMethodName = 'Refrigerated Air Freight')