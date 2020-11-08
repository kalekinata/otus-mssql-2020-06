/* 3. Создать одинаковую функцию и хранимую процедуру, посмотреть в чем разница в производительности и почему.*/

CREATE PROCEDURE sum_customers_sales
	@CustomerID int
AS
	BEGIN
		SELECT SUM((il.Quantity)*(UnitPrice))
		FROM Sales.Customers c
			JOIN Sales.Invoices i ON c.CustomerID = i.CustomerID
			JOIN Sales.InvoiceLines il ON i.InvoiceID = il.InvoiceID
		WHERE c.CustomerID = @CustomerID and i.CustomerID = @CustomerID
		GROUP BY c.CustomerID, c.CustomerName
	END



CREATE FUNCTION sum_custom_sales
	(@CustomerID int)
RETURNS float
	BEGIN
		DECLARE @sum float
		SELECT @sum = Sum((il.Quantity)*(UnitPrice))
		FROM Sales.Customers c
			JOIN Sales.Invoices i ON c.CustomerID = i.CustomerID
			JOIN Sales.InvoiceLines il ON i.InvoiceID = il.InvoiceID
		WHERE c.CustomerID = @CustomerID and i.CustomerID = @CustomerID
		RETURN @sum
	END


EXEC sum_customers_sales 10
Select dbo.sum_custom_sales(10)

/*В планах видно, что выполнение функции намного меньше по стоимости, чем выполнение хранимой процедуры.
  Так как план выполнения функции состоит из SELECT, Вычисления скалярного значения и Constant Scan,
  а при выполнении хранимой процедуры план состоин из SELECT, Вычисление скалярного произведения, Aggregate,
  Вложенного цикла(который разветвляется на Hash Match, Поиск в индексе, Вычисление скалаярного значения, Просмотр индекса),
  Вложенные циклы, Поиск кластеризованного индекса, Concatenation, Фильтр, Constant Scan, Фильтр, Вложенные циклы, Constant Scan,
  Assert, Aggregate, Вложенные циклы, Вложенные циклы, Фильтр, Поиск кластеризованного индекса, Фильтр.
  В связи с чем получается, что план хранимой процедуры является более разветвлённым, чем план выполнения функции.*/
