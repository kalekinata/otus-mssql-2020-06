/* 1. ��������� �������� ������, ������� � ���������� ������ ���������� ��������� ������� ���������� ����:
- �������� �������
- ��������
- ���������� �������

�������� ����� � ID 2-6, ��� ��� ������������� Tailspin Toys.
��� ������� ����� �������� ��� ����� �������� ������ ���������.
�������� �������� Tailspin Toys (Gasport, NY) - �� �������� � ����� ������ Gasport,NY
���� ������ ����� ������ dd.mm.yyyy �������� 25.12.2019

��������, ��� ������ ��������� ����������:
InvoiceMonth Peeples Valley, AZ Medicine Lodge, KS Gasport, NY Sylvanite, MT Jessie, ND
01.01.2013 3 1 4 2 2
01.02.2013 7 3 4 2 1 */

SELECT *
FROM(
		SELECT SUBSTRING(c.CustomerName, 16,LEN(c.CustomerName)-16) AS CustomerName, FORMAT(i.InvoiceDate,'dd.MM.yyyy') AS InvoiceMonth, il.InvoiceID
		FROM Sales.Customers c
		JOIN Sales.Invoices i ON c.CustomerID = i.CustomerID
		JOIN Sales.InvoiceLines il ON i.InvoiceID = il.InvoiceID
		WHERE c.CustomerID between 2 and 6
	) AS Customer
PIVOT(count(InvoiceID)
	FOR CustomerName IN ([Sylvanite, MT], [Peeples Valley, AZ], [Medicine Lodge, KS], [Gasport, NY], [Jessie, ND])) AS  PVT
ORDER BY YEAR(PVT.InvoiceMonth), DAY(PVT.InvoiceMonth), MONTH(PVT.InvoiceMonth)