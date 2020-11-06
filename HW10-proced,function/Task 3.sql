/* 3. ������� ���������� ������� � �������� ���������, ���������� � ��� ������� � ������������������ � ������.*/

CREATE PROCEDURE sum_customers_sales
	@�ustomerID int
AS
	BEGIN
		SELECT SUM((il.Quantity)*(UnitPrice))
		FROM Sales.Customers c
			JOIN Sales.Invoices i ON c.CustomerID = i.CustomerID
			JOIN Sales.InvoiceLines il ON i.InvoiceID = il.InvoiceID
		WHERE c.CustomerID = @�ustomerID and i.CustomerID = @�ustomerID
		GROUP BY c.CustomerID, c.CustomerName
	END

EXEC sum_customers_sales 10

CREATE FUNCTION sum_custom_sales
	(@�ustomerID int)
RETURNS int
	BEGIN
		DECLARE @sum int
		SELECT @sum = Sum((il.Quantity)*(UnitPrice))
		FROM Sales.Customers c
			JOIN Sales.Invoices i ON c.CustomerID = i.CustomerID
			JOIN Sales.InvoiceLines il ON i.InvoiceID = il.InvoiceID
		WHERE c.CustomerID = @�ustomerID and i.CustomerID = @�ustomerID
		RETURN @sum
	END

EXEC sum_custom_sales 10