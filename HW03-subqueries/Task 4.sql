/* 4. Выберите города (ид и название), в которые были доставлены товары, входящие в тройку самых дорогих товаров, а также имя сотрудника, который осуществлял упаковку заказов (PackedByPersonID).*/

-------1 вариант---------
SELECT CityID,CityName, FullName
FROM Application.People P
JOIN Application.Cities C ON P.PersonID = C.LastEditedBy
JOIN Sales.Invoices I ON P.PersonID = I.PackedByPersonID
JOIN Warehouse.StockItems S ON P.PersonID = S.LastEditedBy
WHERE UnitPrice IN (SELECT TOP 3 UnitPrice
					FROM Warehouse.StockItems
					ORDER BY UnitPrice DESC)

-------2 вариант---------
SELECT CityID,CityName, FullName
FROM Application.People P
JOIN Application.Cities C ON P.PersonID = C.LastEditedBy
JOIN Sales.Invoices I ON P.PersonID = I.PackedByPersonID
JOIN Warehouse.StockItems S ON P.PersonID = S.LastEditedBy
WHERE UnitPrice = ANY (SELECT TOP 3 UnitPrice
					FROM Warehouse.StockItems
					ORDER BY UnitPrice DESC)