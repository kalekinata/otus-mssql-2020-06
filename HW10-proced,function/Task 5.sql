/*5. Опционально. Переписать процедуру kitchen sink с множеством входных параметров по поиску в заказах на динамический SQL. Сравнить планы запроса.
Текст процедуры в материалах к занятию в файле 70_Kitchen_sink_HomeTask.sql */

CREATE PROCEDURE dbo.CustomerSearch_KitchenSinkOtus
  @CustomerID            int            = NULL,
  @CustomerName          nvarchar(100)  = NULL,
  @BillToCustomerID      int            = NULL,
  @CustomerCategoryID    int            = NULL,
  @BuyingGroupID         int            = NULL,
  @MinAccountOpenedDate  date           = NULL,
  @MaxAccountOpenedDate  date           = NULL,
  @DeliveryCityID        int            = NULL,
  @IsOnCreditHold        bit            = NULL,
  @OrdersCount		 int		= NULL, 
  @PersonID		 int		= NULL, 
  @DeliveryStateProvince int		= NULL,
  @PrimaryContactPersonIDIsEmployee BIT = NULL

AS
BEGIN
  SET NOCOUNT ON;
 
  SELECT CustomerID, CustomerName, IsOnCreditHold
  FROM Sales.Customers AS Client
	JOIN Application.People AS Person ON 
		Person.PersonID = Client.PrimaryContactPersonID
	JOIN Application.Cities AS City ON
		City.CityID = Client.DeliveryCityID
  WHERE (@CustomerID IS NULL 
         OR Client.CustomerID = @CustomerID)
    AND (@CustomerName IS NULL 
         OR Client.CustomerName LIKE @CustomerName)
    AND (@BillToCustomerID IS NULL 
         OR Client.BillToCustomerID = @BillToCustomerID)
    AND (@CustomerCategoryID IS NULL 
         OR Client.CustomerCategoryID = @CustomerCategoryID)
    AND (@BuyingGroupID IS NULL 
         OR Client.BuyingGroupID = @BuyingGroupID)
    AND Client.AccountOpenedDate >= 
        COALESCE(@MinAccountOpenedDate, Client.AccountOpenedDate)
    AND Client.AccountOpenedDate <= 
        COALESCE(@MaxAccountOpenedDate, Client.AccountOpenedDate)
    AND (@DeliveryCityID IS NULL 
         OR Client.DeliveryCityID = @DeliveryCityID)
    AND (@IsOnCreditHold IS NULL 
         OR Client.IsOnCreditHold = @IsOnCreditHold)
	AND ((@OrdersCount IS NULL)
		OR ((SELECT COUNT(*) FROM Sales.Orders
			WHERE Orders.CustomerID = Client.CustomerID)
				>= @OrdersCount
			)
		)
	AND ((@PersonID IS NULL) 
		OR (Client.PrimaryContactPersonID = @PersonID))
	AND ((@DeliveryStateProvince IS NULL)
		OR (City.StateProvinceID = @DeliveryStateProvince))
	AND ((@PrimaryContactPersonIDIsEmployee IS NULL)
		OR (Person.IsEmployee = @PrimaryContactPersonIDIsEmployee)
		);
END


CREATE PROCEDURE dbo.CustomerSearch_KitchenSinkDinamic
  @CustomerID            int            = NULL,
  @CustomerName          nvarchar(100)  = NULL,
  @BillToCustomerID      int            = NULL,
  @CustomerCategoryID    int            = NULL,
  @BuyingGroupID         int            = NULL,
  @MinAccountOpenedDate  date           = NULL,
  @MaxAccountOpenedDate  date           = NULL,
  @DeliveryCityID        int            = NULL,
  @IsOnCreditHold        bit            = NULL,
  @OrdersCount		 int		= NULL, 
  @PersonID		 int		= NULL, 
  @DeliveryStateProvince int		= NULL,
  @PrimaryContactPersonIDIsEmployee bit = NULL

AS
BEGIN
  SET NOCOUNT ON;
  DECLARE @sql nvarchar(max), @param nvarchar(max);

  SET @param = N'@CustomerID            int,
		 @CustomerName          nvarchar(100),
		 @BillToCustomerID      int,
		 @CustomerCategoryID    int,
		 @BuyingGroupID         int,
		 @MinAccountOpenedDate  date,
		 @MaxAccountOpenedDate  date,
		 @DeliveryCityID        int,
		 @IsOnCreditHold        bit,
		 @OrdersCount		int, 
		 @PersonID		int, 
		 @DeliveryStateProvince int,
		 @PrimaryContactPersonIDIsEmployee bit';
  
 SET @sql = 'SELECT CustomerID, CustomerName, IsOnCreditHold
		FROM Sales.Customers c
		JOIN Application.People p ON p.PersonID = c.PrimaryContactPersonID
		JOIN Application.Cities sa ON sa.CityID = c.DeliveryCityID
		WHERE 1=1 '
 IF @CustomerID IS NOT NULL
 	SET @sql = @sql + 'AND c.CustomerID = @CustomerID '
 IF @CustomerName IS NOT NULL
 	SET @sql = @sql + 'AND c.CustomerName LIKE @CustomerName '
 IF @BillToCustomerID IS NOT NULL
 	SET @sql = @sql + 'AND c.BillToCustomerID = @BillToCustomerID '
 IF @CustomerCategoryID IS NOT NULL
 	SET @sql = @sql + 'AND c.CustomerCategoryID = @CustomerCategoryID '
 IF @BuyingGroupID IS NOT NULL
 	SET @sql = @sql + 'AND c.BuyingGroupID = @BuyingGroupID '
 SET @sql = @sql + 'AND c.AccountOpenedDate >= COALESCE(@MinAccountOpenedDate, c.AccountOpenedDate) '
 SET @sql = @sql + 'AND c.AccountOpenedDate >= COALESCE(@MaxAccountOpenedDate, c.AccountOpenedDate) '
 IF @DeliveryCityID IS NOT NULL
 	SET @sql = @sql + 'AND c.DeliveryCityID = @DeliveryCityID '
 IF @IsOnCreditHold IS NOT NULL
 	SET @sql = @sql + 'AND c.IsOnCreditHold = @IsOnCreditHold '
 IF @OrdersCount IS NOT NULL
 	SET @sql = @sql + 'AND (SELECT COUNT(*)
				FROM Sales.Orders
				WHERE Orders.CustomerID = c.CustomerID) >= @OrdersCount '
 IF @PersonID IS NOT NULL
 	SET @sql = @sql + 'AND c.PrimaryContactPersonID = @PersonID '
 IF @DeliveryStateProvince IS NOT NULL
 	SET @sql = @sql + 'AND sa.StateProvinceID = @DeliveryStateProvince '
 IF @PrimaryContactPersonIDIsEmployee IS NOT NULL
 	SET @sql = @sql + 'AND p.IsEmployee = @PrimaryContactPersonIDIsEmployee '
 
 EXEC sys.sp_executesql @sql, @param,
 @CustomerID, @CustomerName, @BillToCustomerID, @CustomerCategoryID, @BuyingGroupID,
 @MinAccountOpenedDate,  @MaxAccountOpenedDate, @DeliveryCityID, @IsOnCreditHold,
 @OrdersCount, @PersonID, @DeliveryStateProvince, @PrimaryContactPersonIDIsEmployee;

END;

SET STATISTICS IO, TIME ON

EXEC dbo.CustomerSearch_KitchenSinkOtus
 @CustomerID = 10,
 @CustomerName = NULL,
 @BillToCustomerID = NULL,
 @CustomerCategoryID = NULL,
 @BuyingGroupID = NULL,
 @MinAccountOpenedDate = NULL,
 @MaxAccountOpenedDate = NULL,
 @DeliveryCityID = NULL,
 @IsOnCreditHold = NULL,
 @OrdersCount = NULL, 
 @PersonID = NULL, 
 @DeliveryStateProvince = NULL,
 @PrimaryContactPersonIDIsEmployee = NULL

EXEC dbo.CustomerSearch_KitchenSinkDinamic
 @CustomerID = 10,
 @CustomerName = NULL,
 @BillToCustomerID = NULL,
 @CustomerCategoryID = NULL,
 @BuyingGroupID = NULL,
 @MinAccountOpenedDate = NULL,
 @MaxAccountOpenedDate = NULL,
 @DeliveryCityID = NULL,
 @IsOnCreditHold = NULL,
 @OrdersCount = NULL, 
 @PersonID = NULL, 
 @DeliveryStateProvince = NULL,
 @PrimaryContactPersonIDIsEmployee = NULL


/* План выполнения процедуры с ипользованием динамического sql по стоимости = 0,003 меньше, чем план выполнения процедуры с параметрами = 0,015.
А также план выполнения процедуры с параметрами более разветвлён, относительно плана  выполнения процедуры с ипользованием динамического sql. */
