/*5. По каждому сотруднику выведите последнего клиента, которому сотрудник что-то продал. В результатах должны быть:
  - ид и фамилия сотрудника,
  - ид и название клиента,
  - дата продажи,
  - сумму сделки. */

--запрос с оконной функцией--
SELECT * FROM (
SELECT o.SalespersonPersonID,
p.FullName AS SalesPersonName,
o.CustomerID,
c.CustomerName AS CustomerName,
o.OrderDate,
ol.Quantity*ol.UnitPrice AS Total,
ROW_NUMBER() OVER (PARTITION BY o.SalespersonPersonID ORDER BY o.OrderDate DESC) AS lastsales
FROM Sales.Orders AS o
JOIN Sales.OrderLines AS ol ON o.OrderID=ol.OrderID
JOIN Application.People AS p ON o.SalespersonPersonID=p.PersonID
JOIN Sales.Customers AS c ON c.CustomerID=o.CustomerID
) AS t
WHERE t.lastsales = 1;
