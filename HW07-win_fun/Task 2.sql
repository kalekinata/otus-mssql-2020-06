/*2. ���� �� ����� ������������ ���� ������, �� �������� ������ ����� ����������� ������ � ������� ������� �������.
�������� 2 �������� ������� - ����� windows function � ��� ���. �������� ����� ������� �����������, �������� �� set statistics time on;. */

set statistics time on;

--������ � ������� ��������--
SELECT DISTINCT i.InvoiceID,
				c.CustomerName,
				i.InvoiceDate,
				(SUM(il.UnitPrice) OVER(ORDER BY MONTH(InvoiceDate))) as Progressive_Total
FROM Sales.Invoices i
	JOIN Sales.InvoiceLines il ON il.InvoiceID = i.InvoiceID
	JOIN Sales.Customers c ON i.CustomerID = c.CustomerID
WHERE InvoiceDate >= '2015.01.01'
ORDER BY InvoiceID;

--������ � �����������--
SELECT distinct i.InvoiceID,
				c.CustomerName,
				i.InvoiceDate,
				(SELECT SUM(il.UnitPrice)
					FROM Sales.Invoices i1
						JOIN Sales.InvoiceLines il ON i1.InvoiceID = il.InvoiceID
					WHERE MONTH(i1.InvoiceDate) = MONTH(i.InvoiceDate) and InvoiceDate >= '2015.01.01'
					GROUP BY MONTH(i1.InvoiceDate)
				) as Progressive_Total
FROM Sales.Invoices i
	JOIN Sales.Customers c ON i.CustomerID = c.CustomerID
WHERE InvoiceDate >= '2015.01.01'
ORDER BY InvoiceID;

--������ � ������� �������� ����������� �������, ��� ������ � �����������. ��� ���������� ������� � ������� �������� ����� �� = 245 ��, �������� ����� = 245 ��, � ��� ���������� ������� � ����������� ���� �� = 625 ��, ����������� ����� = 1575 ��.--