--6. Все ид и имена клиентов и их контактные телефоны, которые покупали товар Chocolate frogs 250g. Имя товара смотреть в Warehouse.StockItems.

SELECT o.CustomerID, CustomerName, p.PhoneNumber, P.FaxNumber, StockItemName
FROM Sales.Orders o
JOIN Sales.Customers c ON o.CustomerID = c.CustomerID
JOIN Application.People p ON o.LastEditedBy = p.PersonID
JOIN (SELECT s.StockItemID, s.StockItemName, s.LastEditedBy,s.SupplierID, ol.OrderID, ol.UnitPrice,ol.Quantity
		FROM Warehouse.StockItems s
		JOIN Sales.OrderLines ol ON s.StockItemID = ol.StockItemID) AS Stockitem ON o.OrderID = Stockitem.OrderID
WHERE StockItemName = 'Chocolate frogs 250g'
