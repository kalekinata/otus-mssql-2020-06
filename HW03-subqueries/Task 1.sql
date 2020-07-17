/*1. Выберите сотрудников (Application.People), которые являются продажниками (IsSalesPerson), и не сделали 
 ни одной продажи 04 июля 2015 года. Вывести ИД сотрудника и его полное имя. Продажи смотреть в таблице Sales.Invoices.*/
SELECT p.PersonID, p.FullName
FROM Application.People p
WHERE EXISTS(SELECT *
		FROM Sales.Invoices i
		WHERE p.IsSalesperson = i.CustomerID AND (InvoiceID IS NULL) AND InvoiceDate = '2015-07-04')
