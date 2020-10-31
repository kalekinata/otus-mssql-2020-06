/*1. Загрузить данные из файла StockItems.xml в таблицу Warehouse.StockItems.
Существующие записи в таблице обновить, отсутствующие добавить (сопоставлять записи по полю StockItemName).
Файл StockItems.xml в личном кабинете.*/

DECLARE @x XML
SET @x = ( 
  SELECT * FROM OPENROWSET
  (BULK 'C:\1\StockItems.xml',
   SINGLE_BLOB)
   as d)

select @x
