--5. Десять последних продаж (по дате) с именем клиента и именем сотрудника, который оформил заказ (SalespersonPerson).

SELECT TOP 10 OrderID, OrderDate, c.CustomerName, p.FullName
FROM Sales.Orders o
JOIN Sales.Customers c ON o.CustomerID = c.CustomerID
JOIN Application.People p ON o.SalespersonPersonID = p.PersonID 
ORDER BY OrderDate DESC