/*4) Создайте табличную функцию покажите как ее можно вызвать для каждой строки result set'а без использования цикла.*/

CREATE FUNCTION customer_sales (@CustomerId int)  
RETURNS TABLE  
AS  
RETURN   
(  
    SELECT c.CustomerName, si.StockItemID, si.StockItemName, SUM(OL.Quantity) AS 'Quantity'  
    FROM Warehouse.StockItems AS si   
    JOIN Sales.OrderLines AS ol ON ol.StockItemID = si.StockItemID  
    JOIN Sales.Orders AS o ON o.OrderID = ol.OrderID  
    JOIN Sales.Customers AS c ON o.CustomerID = c.CustomerID  
    WHERE o.CustomerID = @CustomerId  
    GROUP BY c.CustomerName, si.StockItemID, si.StockItemName  
)

EXEC ('SELECT * FROM dbo.customer_sales (10)')
WITH RESULT SETS
(
	(
	 [CustomerName] varchar(50),
	 [StockItemID] int,
	 [StockItemName] varchar(50),
	 [Qiantity] int
	)
)