/* 3. Изменить одну запись, из добавленных через UPDATE. */
UPDATE Sales.Customers
SET PostalAddressLine1 = 'PO Box 982'
WHERE CustomerName = 'Marilyn Manson'