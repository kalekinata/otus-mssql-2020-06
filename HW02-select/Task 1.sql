--1. ��� ������, � �������� ������� ���� "urgent" ��� �������� ���������� � "Animal"
--�������: Warehouse.StockItems.

SELECT StockItemID, StockItemName
FROM Warehouse.StockItems
WHERE (StockItemName LIKE '%urgent%') OR (StockItemName LIKE 'Animal%')