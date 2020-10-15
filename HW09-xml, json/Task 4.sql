/* 4. ����� � StockItems ������, ��� ���� ��� "Vintage".
�������:
- StockItemID
- StockItemName
- (�����������) ��� ���� (�� CustomFields) ����� ������� � ����� ����

���� ������ � ���� CustomFields, � �� � Tags.
������ �������� ����� ������� ������ � JSON.
��� ������ ������������ ���������, ������������ LIKE ���������.

������ ���� � ����� ����:
... where ... = 'Vintage'

��� ������� �� �����:
... where ... Tags like '%Vintage%'
... where ... CustomFields like '%Vintage%'
*/
select StockItemID, StockItemName,(select json_query((select top 1 CustomFields as CustomFields from Warehouse.StockItems where StockItemID = t.StockItemID),'$.Tags')) as Tags
from Warehouse.StockItems t
where (select json_value((select top 1 CustomFields as CustomFields from Warehouse.StockItems where StockItemID = t.StockItemID),'$.Tags[0]')) = 'Vintage' or (select json_value((select top 1 CustomFields as CustomFields from Warehouse.StockItems where StockItemID = t.StockItemID),'$.Tags[1]')) = 'Vintage' or(select json_value((select top 1 CustomFields as CustomFields from Warehouse.StockItems where StockItemID = t.StockItemID),'$.Tags[2]')) = 'Vintage'