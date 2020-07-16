/*3. Выберите информацию по клиентам, которые перевели компании пять максимальных платежей из Sales.CustomerTransactions.
Представьте несколько способов (в том числе с CTE).*/

--------Подзапрос. 1 вариант.--------
SELECT CustomerID, FullName, PersonID
FROM Sales.CustomerTransactions CT
JOIN Application.People P ON CT.LastEditedBy = P.PersonID
WHERE TransactionAmount IN (SELECT TOP 5 TransactionAmount
							FROM Sales.CustomerTransactions
							ORDER BY TransactionAmount DESC)

--------Подзапрос. 2 вариант.--------
SELECT CustomerID, FullName, PersonID
FROM Sales.CustomerTransactions CT
JOIN Application.People P ON CT.LastEditedBy = P.PersonID
WHERE TransactionAmount = ANY(SELECT TOP 5 TransactionAmount
							FROM Sales.CustomerTransactions
							ORDER BY TransactionAmount DESC)
							
--------CTE. 1 вариант---------
;WITH TOP5Customer as
(
	SELECT TOP 5 TransactionAmount
	FROM Sales.CustomerTransactions
	ORDER BY TransactionAmount DESC
) 
SELECT CustomerID, FullName, PersonID
FROM Sales.CustomerTransactions CT
JOIN Application.People P ON CT.LastEditedBy = P.PersonID
WHERE TransactionAmount in ( Select * FROM TOP5Customer)

--------CTE. 2 вариант---------
;WITH TOP5Customer as
(
	SELECT TOP 5 TransactionAmount
	FROM Sales.CustomerTransactions
	ORDER BY TransactionAmount DESC
) 
SELECT CustomerID, FullName, PersonID
FROM Sales.CustomerTransactions CT
JOIN Application.People P ON CT.LastEditedBy = P.PersonID
WHERE TransactionAmount = ANY ( Select * FROM TOP5Customer)
