/*1. Написать функцию возвращающую Клиента с наибольшей суммой покупки.*/

CREATE PROCEDURE fun_sales
AS
	BEGIN
		SELECT c.CustomerID, c.CustomerName, ct.TransactionAmount
		FROM Sales.CustomerTransactions ct
		JOIN Sales.Customers c on c.CustomerID = ct.CustomerID
		WHERE ct.TransactionAmount = (SELECT MAX(TransactionAmount) from Sales.CustomerTransactions)
	END

EXEC fun_sales