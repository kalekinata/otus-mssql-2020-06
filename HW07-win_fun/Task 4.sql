/*4. ������� ����� ��������
1) ���������� �� ������� �������, � ����� ����� ������ ������� 
- �� ������,
- ��������,
- ����� � ����;
2) ������������ ������ �� �������� ������, ��� ����� ��� ��������� ����� �������� ��������� ���������� ������;
3) ���������� ����� ���������� ������� � �������� ����� � ���� �� �������;
4) ���������� ����� ���������� ������� � ����������� �� ������ ����� �������� ������;
5) ���������� ��������� id ������ ������ �� ����, ��� ������� ����������� ������� �� �����;
6) ���������� �� ������ � ��� �� �������� ����������� (�� �����);
7) �������� ������ 2 ������ �����, � ������ ���� ���������� ������ ��� ����� ������� "No items";
8) ����������� 30 ����� ������� �� ���� ��� ������ �� 1 ��.

��� ���� ������ �� ����� ������ ������ ��� ������������� �������*/

select StockItemID, StockItemName, Brand, UnitPrice,
	ROW_NUMBER() OVER(PARTITION BY LEFT(StockItemName,1) ORDER BY StockItemName) AS numb,
	COUNT(StockItemName) OVER() AS total_num,
	COUNT(StockItemName) OVER(PARTITION BY LEFT(StockItemName,1)) AS total_num_name,
	LEAD(StockItemID) OVER(ORDER BY StockItemName) AS lead,
	LAG(StockItemID) OVER(ORDER BY StockItemName) AS lag,
	LAG(StockItemName,2,'No items') OVER(ORDER BY StockItemName) AS lag_two,
	NTILE(30) OVER(ORDER BY TypicalWeightPerUnit) AS [group]
from Warehouse.StockItems
ORDER BY StockItemName