/* 4.Написать MERGE, который вставит вставит запись в клиенты, если ее там нет, и изменит если она уже есть. */

MERGE Sales.Customers AS target
USING (SELECT CustomerID, CustomerName, BillToCustomerID, cc.CustomerCategoryID, PrimaryContactPersonID, dm.DeliveryMethodID, DeliveryCityID, PostalCityID, CreditLimit, AccountOpenedDate, StandardDiscountPercentage, IsStatementSent,IsOnCreditHold, PaymentDays, p.PhoneNumber, p.FaxNumber, DeliveryRun, RunPosition, WebsiteURL, DeliveryAddressLine1, DeliveryAddressLine2, DeliveryPostalCode, PostalAddressLine1, PostalAddressLine2, PostalPostalCode, p.LastEditedBy
		FROM Sales.Customers c
		JOIN Application.People p ON c.AlternateContactPersonID = p.PersonID and c.PrimaryContactPersonID = p.PersonID
		JOIN Sales.BuyingGroups b ON c.BuyingGroupID = b.BuyingGroupID
		JOIN Sales.CustomerCategories cc ON c.CustomerCategoryID = cc.CustomerCategoryID
		JOIN Application.Cities ac ON c.DeliveryCityID = ac.CityID and c.PostalCityID = ac.CityID
		JOIN Application.DeliveryMethods dm ON c.DeliveryMethodID = dm.DeliveryMethodID)
		AS source(CustomerID, CustomerName, BillToCustomerID, CustomerCategoryID, PrimaryContactPersonID, DeliveryMethodID, DeliveryCityID, PostalCityID, CreditLimit, AccountOpenedDate, StandardDiscountPercentage, IsStatementSent,IsOnCreditHold, PaymentDays, PhoneNumber, FaxNumber, DeliveryRun, RunPosition, WebsiteURL, DeliveryAddressLine1, DeliveryAddressLine2, DeliveryPostalCode, PostalAddressLine1, PostalAddressLine2, PostalPostalCode, LastEditedBy)
		ON (target.CustomerID = source.CustomerID)
		WHEN MATCHED
			THEN UPDATE SET CustomerID = source.CustomerID,
				CustomerName = source.CustomerName,
				BillToCustomerID = source.BillToCustomerID,
				CustomerCategoryID = source.CustomerCategoryID,
				PrimaryContactPersonID = source.PrimaryContactPersonID,
				DeliveryMethodID = source.DeliveryMethodID,
				DeliveryCityID = source.DeliveryCityID,
				PostalCityID = source.PostalCityID,
				CreditLimit = source.CreditLimit,
				AccountOpenedDate = source.AccountOpenedDate,
				StandardDiscountPercentage = source.StandardDiscountPercentage,
				IsStatementSent = source.IsStatementSent,
				IsOnCreditHold = source.IsOnCreditHold,
				PaymentDays = source.PaymentDays,
				PhoneNumber = source.PhoneNumber,
				FaxNumber = source.FaxNumber,
				DeliveryRun = source.DeliveryRun,
				RunPosition = source.RunPosition,
				WebsiteURL = source.WebsiteURL,
				DeliveryAddressLine1 = source.DeliveryAddressLine1,
				DeliveryAddressLine2 = source.DeliveryAddressLine2,
				DeliveryPostalCode = source.DeliveryPostalCode,
				PostalAddressLine1 = source.PostalAddressLine1,
				PostalAddressLine2 = source.PostalAddressLine2,
				PostalPostalCode = source.PostalPostalCode,
				LastEditedBy = source.LastEditedBy
		WHEN NOT MATCHED
			THEN INSERT(CustomerID, CustomerName, BillToCustomerID, CustomerCategoryID, PrimaryContactPersonID, DeliveryMethodID, DeliveryCityID, PostalCityID, CreditLimit, AccountOpenedDate, StandardDiscountPercentage, IsStatementSent,IsOnCreditHold, PaymentDays, PhoneNumber, FaxNumber, DeliveryRun, RunPosition, WebsiteURL, DeliveryAddressLine1, DeliveryAddressLine2, DeliveryPostalCode, PostalAddressLine1, PostalAddressLine2, PostalPostalCode, LastEditedBy)
			VALUES (source.CustomerID, source.CustomerName, source.BillToCustomerID, source.CustomerCategoryID, source.PrimaryContactPersonID, source.DeliveryMethodID, source.DeliveryCityID, source.PostalCityID, source.CreditLimit, source.AccountOpenedDate, source.StandardDiscountPercentage, source.IsStatementSent,source.IsOnCreditHold, source.PaymentDays, source.PhoneNumber, source.FaxNumber, source.DeliveryRun, source.RunPosition, source.WebsiteURL, source.DeliveryAddressLine1, source.DeliveryAddressLine2, source.DeliveryPostalCode, source.PostalAddressLine1, source.PostalAddressLine2, source.PostalPostalCode, source.LastEditedBy)
		OUTPUT deleted.*,$action,inserted.*;