/* 2. ��������� ������ �� ������� StockItems � ����� �� xml-����, ��� StockItems.xml */

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