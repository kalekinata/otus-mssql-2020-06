/*2. Выберите товары с минимальной ценой (подзапросом). Сделайте два варианта подзапроса. Вывести: ИД товара, наименование товара, цена.*/
-------1 вариант---------
SELECT StockItemID, StockItemName, UnitPrice
FROM Warehouse.StockItems
WHERE UnitPrice = (SELECT MIN(UnitPrice)
					FROM Warehouse.StockItems)

-------2 вариант--------
SELECT StockItemID, StockItemName, UnitPrice
FROM Warehouse.StockItems
WHERE UnitPrice <= ALL(SELECT UnitPrice
						FROM Warehouse.StockItems)