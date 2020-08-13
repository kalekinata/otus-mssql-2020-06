/*3. ������� ������ 2� ����� ���������� ��������� (�� ���-�� ���������) � ������ ������ �� 2016� ��� (�� 2 ����� ���������� �������� � ������ ������)*/

SELECT *
FROM
	(
		SELECT InvoiceDate, StockItemName, Quantity,
			ROW_NUMBER() OVER(PARTITION BY month(InvoiceDate) ORDER BY Quantity DESC, InvoiceDate) AS quan_num
		FROM Sales.Invoices i
			join Sales.InvoiceLines il on i.InvoiceID = il.InvoiceID
			join Warehouse.StockItems si on il.StockItemID = si.StockItemID
		where YEAR(InvoiceDate) = '2016'
	) AS tab
WHERE quan_num <= 2
ORDER BY InvoiceDate