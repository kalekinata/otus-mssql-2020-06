/*2. ���� �� ����� ������������ ���� ������, �� �������� ������ ����� ����������� ������ � ������� ������� �������.
�������� 2 �������� ������� - ����� windows function � ��� ���. �������� ����� ������� �����������, �������� �� set statistics time on;. */

set statistics time on;

--������ � ������� ��������--
SELECT DISTINCT i.InvoiceID,
				c.CustomerName,
				i.InvoiceDate,
				(SUM(ct.TransactionAmount) OVER(ORDER BY MONTH(InvoiceDate))) as Progressive_Total
FROM Sales.Invoices i
	JOIN Sales.CustomerTransactions ct ON i.InvoiceID = ct.InvoiceID
	JOIN Sales.Customers c ON i.CustomerID = c.CustomerID
WHERE InvoiceDate >= '2015.01.01'
ORDER BY InvoiceID;

--������ � �����������--
SELECT distinct i.InvoiceID,
				c.CustomerName,
				i.InvoiceDate,
				(SELECT SUM(ct.TransactionAmount)
					FROM Sales.Invoices i1
						JOIN Sales.CustomerTransactions ct ON i1.InvoiceID = ct.InvoiceID
					WHERE MONTH(i1.InvoiceDate) = MONTH(i.InvoiceDate) and InvoiceDate >= '2015.01.01'
					GROUP BY MONTH(i1.InvoiceDate)
				) as Progressive_Total
FROM Sales.Invoices i
	JOIN Sales.Customers c ON i.CustomerID = c.CustomerID
WHERE InvoiceDate >= '2015.01.01'
ORDER BY InvoiceID;

--������ � ������� �������� ����������� �������, ��� ������ � �����������. ��� ���������� ������� � ������� �������� ����� �� = 245 ��, �������� ����� = 245 ��, � ��� ���������� ������� � ����������� ���� �� = 625 ��, ����������� ����� = 1575 ��.--