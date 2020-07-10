--3. ������ (Orders) � ����� ������ ����� 100$ ���� ����������� ������ ������ ����� 20 ���� � �������������� ����� ������������ ����� ������ (PickingCompletedWhen).
--�������:
--* OrderID
--* ���� ������ � ������� ��.��.����
--* �������� ������, � ������� ���� �������
--* ����� ��������, � �������� ��������� �������
--* ����� ����, � ������� ��������� ���� ������� (������ ����� �� 4 ������)
--* ��� ��������� (Customer)
--�������� ������� ����� ������� � ������������ ��������, ��������� ������ 1000 � ��������� ��������� 100 �������. ���������� ������ ���� �� ������ ��������, ����� ����, ���� ������ (����� �� �����������).
--�������: Sales.Orders, Sales.OrderLines, Sales.Customers.

SELECT S.OrderID, CONVERT(VarChar, OrderDate, 104) as orDate, DATENAME(MONTH,OrderDate) as month,DATEPART(QUARTER,OrderDate) as quarterNum,
CASE
	WHEN MONTH(OrderDate) BETWEEN 1 AND 4
	THEN 1
	WHEN MONTH(OrderDate) BETWEEN 5 AND 8
	THEN 2
	WHEN MONTH(OrderDate) BETWEEN 9 AND 12
	THEN 3
END third_year,
CustomerName
FROM Sales.Orders S
JOIN Sales.OrderLines L ON S.OrderID = L.OrderID
JOIN Sales.Customers C ON S.CustomerID = C.CustomerID
Where (UnitPrice > 100) OR (Quantity > 20)
ORDER BY quarterNum ASC, orDate ASC, third_year ASC
OFFSET 1000 ROW FETCH NEXT 100 ROWS ONLY

