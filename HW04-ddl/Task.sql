CREATE DATABASE train_station

CREATE TABLE trains_model
(
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	dadd DATE NOT NULL,
	title VARCHAR(50) NOT NULL,
	type VARCHAR(50) NOT NULL,
	markup FLOAT NOT NULL
)


INSERT INTO trains_model(dadd,title,type, markup) VALUES
(getdate(),'Соловей','Фирменный', 0.458),
(getdate(),'Сапсан','Высокоскоростной',2.196),
(getdate(),'Стриж','Скоростной', 2.065),
(getdate(),'Ласточка','Скоростной', 0),
(getdate(),'РЖД/ФПК','Фирменный',0.458)

CREATE TABLE trains
(
	id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	dadd DATE NOT NULL,
	m_id INT FOREIGN KEY REFERENCES trains_model(id) not null,
	number VARCHAR(10) NOT NULL,
	cars INT NOT NULL
)

INSERT INTO trains(dadd,m_id,number, cars)
VALUES (getdate(),1,'105Г', 12),
(getdate(),1,'106Ч', 10),
(getdate(),4,'730Г',9),
(getdate(),4,'719М',13),
(getdate(),2,'751А',7),
(getdate(),2,'758*Н',11),
(getdate(),5,'083М',7),
(getdate(),5,'082В',8),
(getdate(),3,'704Н',12),
(getdate(),3,'013М',6),
(getdate(),1,'106Х',9)

ALTER TABLE trains ADD CHECK(cars<20)

CREATE TABLE passengers
(
	id INT PRIMARY KEY IDENTITY(1,1) not null,
	dadd DATE NOT NULL,
	first_name VARCHAR(20) NOT NULL,
	middle_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	birthday DATE NOT NULL,
	passport BIGINT NOT NULL,
	phone VARCHAR(20),
	email VARCHAR(30)
)
INSERT INTO passengers(dadd,first_name, middle_name, last_name, birthday, passport)
VALUES 
(getdate(),'Виктория','Александровна','Иванова','2000-01-25',1782928172),
(getdate(),'Инна','Викторовна','Козловская','2000-11-28',1827987362),
(getdate(),'Михаил','Павлович','Потапов','1987-03-27',1982928372),
(getdate(),'Елена','Владимировна','Пащенко','1990-06-28',2983918273),
(getdate(),'Светлана','Анатольевна','Миранчук','1995-02-23',1762982736),
(getdate(),'Глеб','Евгеньевич','Булаткин','2001-09-11',1982982733),
(getdate(),'Виктория','Викторовна','Чалова','1999-09-28',1982298374),
(getdate(),'Пётр','Алексеевич','Иванов','1985-02-04',1985928374)


CREATE TABLE stopping
(
	id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	dadd DATE NOT NULL,
	title VARCHAR(30) NOT NULL
)

INSERT INTO stopping(dadd,title)
VALUES (getdate(),'Орёл'),
(getdate(),'Поныри'),
(getdate(),'Ковров-1'),
(getdate(),'Серпухов'),
(getdate(),'Тверь'),
(getdate(),'Новочеркасск'),
(getdate(),'Спирово'),
(getdate(),'Брест-Центральный'),
(getdate(),'Золотухино'),
(getdate(),'Москва'),
(getdate(),'Курск'),
(getdate(),'Нижний Новгород'),
(getdate(),'Белгород'),
(getdate(),'Адлер'),
(getdate(),'Берлин'),
(getdate(),'Санкт-Петербург'),
(getdate(),'Тула-1-Курская'),
(getdate(),'Железнодорожная'),
(getdate(),'Орехово-Зуево'),
(getdate(),'Владимир'),
(getdate(),'Вязники'),
(getdate(),'Гороховец'),
(getdate(),'Дзержинск'),
(getdate(),'Воронеж-1'),
(getdate(),'Россошь'),
(getdate(),'Каменская'),
(getdate(),'Зверево'),
(getdate(),'Ростов-Главный'),
(getdate(),'Краснодар-1'),
(getdate(),'Горячий Ключ'),
(getdate(),'Туапсе-Пасс.'),
(getdate(),'Лазаревская'),
(getdate(),'Лоо'),
(getdate(),'Сочи'),
(getdate(),'Хоста'),
(getdate(),'Смоленск'),
(getdate(),'Орша-Центральная'),
(getdate(),'Минск-Пасс.'),
(getdate(),'Тресполь'),
(getdate(),'Варшава Всходня'),
(getdate(),'Познань-Главная'),
(getdate(),'Жепин'),
(getdate(),'Франкфурт-на-Одере'),
(getdate(),'Берлин Остбанхоф'),
(getdate(),'Мценск'),
(getdate(),'Малоархангельск'),
(getdate(),'Щёкино'),
(getdate(),'Окуловка'),
(getdate(),'Прохоровка'),
(getdate(),'Обухово'),
(getdate(),'Колпино'),
(getdate(),'Тосно'),
(getdate(),'Крюково(Зеленоград)')

CREATE INDEX NT_id
ON stopping(id)

CREATE TABLE [routes]
(
	id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	dadd DATE NOT NULL,
	beg_point INT FOREIGN KEY REFERENCES stopping(id) NOT NULL,
	end_point INT FOREIGN KEY REFERENCES stopping(id) NOT NULL,
	beg_time TIME NOT NULL,
	end_time TIME NOT NULL,
	duration VARCHAR(40)  NOT NULL,
	distance FLOAT NOT NULL,
	price_100kl FLOAT NOT NULL CHECK(price_100kl>0),
	price_place FLOAT NOT NULL
)
INSERT INTO [routes](dadd,beg_point, end_point,beg_time, end_time, duration, distance, price_100kl, price_place)
VALUES (getdate(),10,11,'21:58','05:00','7 часов 2 минуты',537,10,1820),
(getdate(),10,12,'09:33','13:31','3 часа 35 минут',442,10,912),
(getdate(),10,13,'14:22','22:02','7 часов 40 минут',697,12,1543),
(getdate(),10,14,'22:50','09:35','1 день 10 часов 45 минут',1884,20,2864),
(getdate(),10,15,'09:56','06:46','22 часа 50 минут',1787,18,1678),
(getdate(),11,10,'06:22','12:07','5 часов 45 минут',537,10,1544),
(getdate(),11,10,'21:44','06:32','8 часов 48 минут',537,10,1314),
(getdate(),12,16,'05:05','13:20','8 часов 15 минут',1102,13,4250),
(getdate(),13,16,'19:10','10:25','15 часо 15 минут',1357,13,2359),
(getdate(),16,10,'15:16','21:58','6 часов 42 минуты',650,11,1999)

CREATE INDEX NT_id
ON [routes](id)
CREATE INDEX NT_beg_point
ON [routes](beg_point)
CREATE INDEX NT_end_point
ON [routes](end_point)