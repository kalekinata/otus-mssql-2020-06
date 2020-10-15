/*3. � ������� Warehouse.StockItems � ������� CustomFields ���� ������ � JSON.
�������� SELECT ��� ������:
- StockItemID
- StockItemName
- CountryOfManufacture (�� CustomFields)
- FirstTag (�� ���� CustomFields, ������ �������� �� ������� Tags)*/

select	  StockItemID
		, StockItemName
		, (select json_value((select top 1 CustomFields as CustomFields from Warehouse.StockItems where StockItemID = si.StockItemID),'$.CountryOfManufacture')) CountryOfManufacture
		, (select json_value((select top 1 CustomFields as CustomFields from Warehouse.StockItems where StockItemID = si.StockItemID),'$.Tags[1]')) FirstTag
	from Warehouse.StockItems si order by StockItemID