/* 2. Для всех клиентов с именем, в котором есть Tailspin Toys вывести все адреса, которые есть в таблице, в одной колонке.

Пример результатов
CustomerName AddressLine
Tailspin Toys (Head Office) Shop 38
Tailspin Toys (Head Office) 1877 Mittal Road
Tailspin Toys (Head Office) PO Box 8975
Tailspin Toys (Head Office) Ribeiroville
..... */

SELECT *
FROM(
		SELECT  CustomerName,
				c.DeliveryAddressLine1,
				c.DeliveryAddressLine2,
				c.PostalAddressLine1,
				c.PostalAddressLine2
		FROM Sales.Customers c
		WHERE CustomerName LIKE 'Tailspin Toys%'
) AS Customer
UNPIVOT(AddressLine
FOR Name IN (DeliveryAddressLine1, DeliveryAddressLine2, PostalAddressLine1, PostalAddressLine2)) AS pvt






