/*4. Функции одним запросом
1) Посчитайте по таблице товаров, в вывод также должен попасть 
- ид товара,
- название,
- брэнд и цена;
2) пронумеруйте записи по названию товара, так чтобы при изменении буквы алфавита нумерация начиналась заново;
3) посчитайте общее количество товаров и выведете полем в этом же запросе;
4) посчитайте общее количество товаров в зависимости от первой буквы названия товара;
5) отобразите следующий id товара исходя из того, что порядок отображения товаров по имени;
6) предыдущий ид товара с тем же порядком отображения (по имени);
7) названия товара 2 строки назад, в случае если предыдущей строки нет нужно вывести "No items";
8) сформируйте 30 групп товаров по полю вес товара на 1 шт.

Для этой задачи НЕ нужно писать аналог без аналитических функций*/

select StockItemID, StockItemName, Brand, UnitPrice,
	ROW_NUMBER() OVER(PARTITION BY LEFT(StockItemName,1) ORDER BY StockItemName) AS numb,
	COUNT(StockItemName) OVER() AS total_num,
	COUNT(StockItemName) OVER(PARTITION BY LEFT(StockItemName,1)) AS total_num_name,
	LEAD(StockItemID) OVER(ORDER BY StockItemName) AS lead,
	LAG(StockItemID) OVER(ORDER BY StockItemName) AS lag,
	LAG(StockItemName,2,'No items') OVER(ORDER BY StockItemName) AS lag_two,
	NTILE(30) OVER(ORDER BY TypicalWeightPerUnit) AS [group]
from Warehouse.StockItems
ORDER BY StockItemName