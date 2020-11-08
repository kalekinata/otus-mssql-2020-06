/* 2. Написать хранимую процедуру с входящим параметром СustomerID, выводящую сумму покупки по этому клиенту.
Использовать таблицы :
Sales.Customers
Sales.Invoices
Sales.InvoiceLines. */

CREATE PROCEDURE sum_customer_sales
	@ÑustomerID int
AS
	BEGIN
		SELECT	 c.CustomerID
				,c.CustomerName
				,SUM((il.Quantity)*(UnitPrice))
		FROM Sales.Customers c
			JOIN Sales.Invoices i ON c.CustomerID = i.CustomerID
			JOIN Sales.InvoiceLines il ON i.InvoiceID = il.InvoiceID
		WHERE c.CustomerID = @ÑustomerID and i.CustomerID = @ÑustomerID
		GROUP BY c.CustomerID, c.CustomerName
	END

EXEC sum_customer_sales 10
