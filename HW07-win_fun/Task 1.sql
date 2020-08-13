/*1. Напишите запрос с временной таблицей и перепишите его с табличной переменной. Сравните планы.
В качестве запроса с временной таблицей и табличной переменной можно взять свой запрос или следующий запрос:
Сделать расчет суммы продаж нарастающим итогом по месяцам с 2015 года (в рамках одного месяца он будет одинаковый, нарастать будет в течение времени выборки)
Выведите id продажи, название клиента, дату продажи, сумму продажи, сумму нарастающим итогом
Пример
Дата продажи Нарастающий итог по месяцу
2015-01-29 4801725.31
2015-01-30 4801725.31
2015-01-31 4801725.31
2015-02-01 9626342.98
2015-02-02 9626342.98
2015-02-03 9626342.98
Продажи можно взять из таблицы Invoices.
Нарастающий итог должен быть без оконной функции.*/

----запрос с временной таблицей----
DROP TABLE IF EXISTS #progressive_total
; with cte as(
	SELECT distinct i.InvoiceID,
	c.CustomerName,
	i.InvoiceDate,
	(SELECT SUM(il.UnitPrice)
	FROM Sales.Invoices i1
	JOIN Sales.InvoiceLines il ON i1.InvoiceID = il.InvoiceID
	WHERE MONTH(i1.InvoiceDate) = MONTH(i.InvoiceDate) and InvoiceDate >= '2015.01.01'
	GROUP BY MONTH(i1.InvoiceDate)) as Progressive_Total
FROM Sales.Invoices i
JOIN Sales.Customers c ON i.CustomerID = c.CustomerID
WHERE InvoiceDate >= '2015.01.01'
)
SELECT * INTO #progressive_total FROM cte
SELECT * FROM #progressive_total ORDER BY InvoiceID 

----запрос с табличной переменной---
DECLARE @table table
(
	InvoiceID int NOT NULL,
	CustomerName nvarchar(100) NOT NULL,
	InvoiceDate date NOT NULL,
	Progressive_Total float not null
)
; with cte as(
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
)
INSERT INTO @table SELECT * FROM cte
SELECT * FROM @table ORDER BY InvoiceID

---Планы примерно одинаковые. Запрос с временной таблице по стоимости меньше, чем запрос с табличной переменной на 0,223.
