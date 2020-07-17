/*1. Выберите сотрудников (Application.People), которые являются продажниками (IsSalesPerson), и не сделали 
 ни одной продажи 04 июля 2015 года. Вывести ИД сотрудника и его полное имя. Продажи смотреть в таблице Sales.Invoices.*/
SELECT PersonID, FullName
FROM Application.People p
WHERE p.IsSalesperson=1 AND NOT EXISTS(SELECT *
		FROM Sales.Invoices i
		WHERE InvoiceDate = '20150704' AND p.PersonID = i.SalespersonPersonID);
