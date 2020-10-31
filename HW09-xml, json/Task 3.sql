/*3. В таблице Warehouse.StockItems в колонке CustomFields есть данные в JSON.
Написать SELECT для вывода:
- StockItemID
- StockItemName
- CountryOfManufacture (из CustomFields)
- FirstTag (из поля CustomFields, первое значение из массива Tags)*/

select	  StockItemID
		, StockItemName
		, (select json_value((select top 1 CustomFields as CustomFields from Warehouse.StockItems where StockItemID = si.StockItemID),'$.CountryOfManufacture')) CountryOfManufacture
		, (select json_value((select top 1 CustomFields as CustomFields from Warehouse.StockItems where StockItemID = si.StockItemID),'$.Tags[1]')) FirstTag
	from Warehouse.StockItems si order by StockItemID
