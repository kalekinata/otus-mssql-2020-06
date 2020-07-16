/*1. Выберите сотрудников (Application.People), которые являются продажниками (IsSalesPerson), и не сделали 
 ни одной продажи 04 июля 2015 года. Вывести ИД сотрудника и его полное имя. Продажи смотреть в таблице Sales.Invoices.*/
SELECT PersonID, FullName
FROM Application.People
WHERE IsSalesperson = (SELECT CustomerID
						FROM Sales.Invoices
						WHERE (InvoiceID IS NULL) AND InvoiceDate = '2015-07-04')
