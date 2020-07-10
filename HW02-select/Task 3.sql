--3. Заказы (Orders) с ценой товара более 100$ либо количеством единиц товара более 20 штук и присутствующей датой комплектации всего заказа (PickingCompletedWhen).
--Вывести:
--* OrderID
--* дату заказа в формате ДД.ММ.ГГГГ
--* название месяца, в котором была продажа
--* номер квартала, к которому относится продажа
--* треть года, к которой относится дата продажи (каждая треть по 4 месяца)
--* имя заказчика (Customer)
--Добавьте вариант этого запроса с постраничной выборкой, пропустив первую 1000 и отобразив следующие 100 записей. Сортировка должна быть по номеру квартала, трети года, дате заказа (везде по возрастанию).
--Таблицы: Sales.Orders, Sales.OrderLines, Sales.Customers.

SELECT S.OrderID, CONVERT(VarChar, OrderDate, 104) as orDate, DATENAME(MONTH,OrderDate) as month,DATEPART(QUARTER,OrderDate) as quarterNum,
CASE
	WHEN MONTH(OrderDate) BETWEEN 1 AND 4
	THEN 1
	WHEN MONTH(OrderDate) BETWEEN 5 AND 8
	THEN 2
	WHEN MONTH(OrderDate) BETWEEN 9 AND 12
	THEN 3
END third_year,
CustomerName
FROM Sales.Orders S
JOIN Sales.OrderLines L ON S.OrderID = L.OrderID
JOIN Sales.Customers C ON S.CustomerID = C.CustomerID
Where (UnitPrice > 100) OR (Quantity > 20)
ORDER BY quarterNum ASC, orDate ASC, third_year ASC
OFFSET 1000 ROW FETCH NEXT 100 ROWS ONLY

