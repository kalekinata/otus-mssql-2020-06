/* 2. �������� �������� ��������� � �������� ���������� �ustomerID, ��������� ����� ������� �� ����� �������.
������������ ������� :
Sales.Customers
Sales.Invoices
Sales.InvoiceLines*/

CREATE PROCEDURE sum_customer_sales
	@�ustomerID int
AS
	BEGIN
		SELECT	 c.CustomerID
				,c.CustomerName
				,SUM((il.Quantity)*(UnitPrice))
		FROM Sales.Customers c
			JOIN Sales.Invoices i ON c.CustomerID = i.CustomerID
			JOIN Sales.InvoiceLines il ON i.InvoiceID = il.InvoiceID
		WHERE c.CustomerID = @�ustomerID and i.CustomerID = @�ustomerID
		GROUP BY c.CustomerID, c.CustomerName
	END

EXEC sum_customer_sales 10