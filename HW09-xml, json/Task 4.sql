/* 4. Найти в StockItems строки, где есть тэг "Vintage".
Вывести:
- StockItemID
- StockItemName
- (опционально) все теги (из CustomFields) через запятую в одном поле

Тэги искать в поле CustomFields, а не в Tags.
Запрос написать через функции работы с JSON.
Для поиска использовать равенство, использовать LIKE запрещено.

Должно быть в таком виде:
... where ... = 'Vintage'

Так принято не будет:
... where ... Tags like '%Vintage%'
... where ... CustomFields like '%Vintage%'. */
select StockItemID, StockItemName,(select json_query((select top 1 CustomFields as CustomFields from Warehouse.StockItems where StockItemID = t.StockItemID),'$.Tags')) as Tags
from Warehouse.StockItems t
where (select json_value((select top 1 CustomFields as CustomFields from Warehouse.StockItems where StockItemID = t.StockItemID),'$.Tags[0]')) = 'Vintage' or (select json_value((select top 1 CustomFields as CustomFields from Warehouse.StockItems where StockItemID = t.StockItemID),'$.Tags[1]')) = 'Vintage' or(select json_value((select top 1 CustomFields as CustomFields from Warehouse.StockItems where StockItemID = t.StockItemID),'$.Tags[2]')) = 'Vintage'
