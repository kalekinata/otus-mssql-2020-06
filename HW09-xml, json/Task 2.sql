/*2. Выгрузить данные из таблицы StockItems в такой же xml-файл, как StockItems.xml

Примечания к заданиям 1, 2:
* Если с выгрузкой в файл будут проблемы, то можно сделать просто SELECT c результатом в виде XML.
* Если у вас в проекте предусмотрен экспорт/импорт в XML, то можете взять свой XML и свои таблицы.
* Если с этим XML вам будет скучно, то можете взять любые открытые данные и импортировать их в таблицы (например, с https://data.gov.ru). */

SELECT  StockItemName as [@Name],
		SupplierID as [SupplierID],
		UnitPackageID as [Package/UnitPackageID],
		OuterPackageID as [Package/OuterPackageID],
		QuantityPerOuter as [Package/QuantityPerOuter],
		TypicalWeightPerUnit as [Package/TypicalWeightPerUnit],
		LeadTimeDays as [LeadTimeDays],
		IsChillerStock as [IsChillerStock],
		TaxRate as [TaxRate],
		UnitPrice as [UnitPrice]
FROM Warehouse.StockItems
FOR XML PATH('Item'), ROOT('StockItems')
