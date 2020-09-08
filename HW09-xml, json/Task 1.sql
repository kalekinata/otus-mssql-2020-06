DECLARE @x XML
SET @x = ( 
  SELECT * FROM OPENROWSET
  (BULK 'C:\1\StockItems.xml',
   SINGLE_BLOB)
   as d)

select @x