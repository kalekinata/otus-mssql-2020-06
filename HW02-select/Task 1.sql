--1. Все товары, в названии которых есть "urgent" или название начинается с "Animal"
--Таблицы: Warehouse.StockItems.

SELECT StockItemID, StockItemName
FROM Warehouse.StockItems
WHERE (StockItemName LIKE '%urgent%') OR (StockItemName LIKE 'Animal%')