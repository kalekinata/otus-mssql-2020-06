/*5. Пишем динамический PIVOT.
По заданию из занятия “Операторы CROSS APPLY, PIVOT, CUBE”.
Требуется написать запрос, который в результате своего выполнения формирует таблицу следующего вида:
Название клиента
МесяцГод Количество покупок

Нужно написать запрос, который будет генерировать результаты для всех клиентов.
Имя клиента указывать полностью из CustomerName.
Дата должна иметь формат dd.mm.yyyy например 01.12.2019*/

DECLARE @query varchar(max), @name varchar(max)
SELECT @name = (SELECT SUBSTRING(c.CustomerName, 16,LEN(c.CustomerName)-16) as CustomerName FROM Sales.Customers c WHERE c.CustomerID between 2 and 6)

set @query = 'SELECT *
FROM(
		SELECT distinct CustomerName, FORMAT(i.InvoiceDate,''dd.MM.yyyy'') AS InvoiceMonth, il.InvoiceID
		FROM Sales.Customers c
		JOIN Sales.Invoices i ON c.CustomerID = i.CustomerID
		JOIN Sales.InvoiceLines il ON i.InvoiceID = il.InvoiceID
		WHERE c.CustomerID between 2 and 6
	) AS Customer
PIVOT(count(InvoiceID)
	FOR CustomerName IN ('+ @name +')) AS  PVT
ORDER BY YEAR(PVT.InvoiceMonth), DAY(PVT.InvoiceMonth), MONTH(PVT.InvoiceMonth)'

exec (@query);
