-- В таблицах используются кластеризованные индексы в качестве первичных ключей. А некластеризованные индексы используются для выполнения запросов по выводу информации.

create table cars
(
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL, --кластеризованный индекс
	creat_date datetime2 NOT NULL,
	[type_id] INT FOREIGN KEY REFERENCES cars_type(id) NOT NULL,
	seats int NOT NULL
)

create table cars_type
(
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL, --кластеризованный индекс
	creat_date datetime2 NOT NULL,
	[type] nvarchar(100) NOT NULL, --некластеризованный индекс
	service_class nvarchar(20) NOT NULL, --некластеризованный индекс
	min_seats int NULL,
	max_seats int NULL,
	markup decimal(10,2) NOT NULL
)

CREATE TABLE trains_model
(
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL, --кластеризованный индекс
	creat_date datetime2 NOT NULL,
	title NVARCHAR(50) NOT NULL,
	[type] NVARCHAR(50) NOT NULL,
	markup decimal(10,2) NOT NULL
)

CREATE NONCLUSTERED INDEX NT_title
ON trains_model(title)

CREATE TABLE trains
(
	id INT PRIMARY KEY IDENTITY(1,1) NOT NULL, --кластеризованный индекс
	creat_date datetime2 NOT NULL,
	m_id INT FOREIGN KEY REFERENCES trains_model(id) not null,
	number NVARCHAR(10) NOT NULL,
	cars INT NOT NULL
)

ALTER TABLE trains ADD CHECK(cars<20)

CREATE TABLE passengers
(
	id INT PRIMARY KEY IDENTITY(1,1) not null, --кластеризованный индекс
	creat_date datetime2 NOT NULL,
	first_name NVARCHAR(20) NOT NULL,
	middle_name NVARCHAR(20) NOT NULL,
	last_name NVARCHAR(20) NOT NULL,
	birthday DATE NOT NULL,
	passport BIGINT NOT NULL, -- некластеризованный индекс
	phone NVARCHAR(20),
	email NVARCHAR(30)
)

CREATE NONCLUSTERED INDEX NT_passport
ON passengers(passport)


CREATE TABLE stopping
(
	id INT PRIMARY KEY IDENTITY(1,1) NOT NULL, --кластеризованный индекс
	creat_date datetime2 NOT NULL,
	title NVARCHAR(30) NOT NULL --некластеризованный индекс
)

CREATE NONCLUSTERED INDEX NT_title
ON stopping(title)


CREATE TABLE [routes]
(
	id INT PRIMARY KEY IDENTITY(1,1) NOT NULL, --кластеризованный индекс
	creat_date datetime2 NOT NULL,
	beg_point INT FOREIGN KEY REFERENCES stopping(id) NOT NULL, -- некластеризованный индекс
	end_point INT FOREIGN KEY REFERENCES stopping(id) NOT NULL, -- некластеризованный индекс
	beg_time TIME NOT NULL, -- некластеризованный индекс
	end_time TIME NOT NULL, -- некластеризованный индекс
	duration NVARCHAR(40)  NOT NULL,
	distance FLOAT NOT NULL,
	price_100kl FLOAT NOT NULL CHECK(price_100kl>0),
	price_place FLOAT NOT NULL -- некластеризованный индекс
)

CREATE NONCLUSTERED INDEX NT_beg_point
ON [routes](beg_point)
CREATE NONCLUSTERED INDEX NT_end_point
ON [routes](end_point)
CREATE NONCLUSTERED INDEX NT_beg_time
ON [routes](beg_time)
CREATE NONCLUSTERED INDEX NT_end_time
ON [routes](end_time)
CREATE NONCLUSTERED INDEX NT_price_place
ON [routes](price_place)


create table routes_stopping
(
	id INT PRIMARY KEY IDENTITY(1,1) NOT NULL, --кластеризованный индекс
	creat_date datetime2 NOT NULL,
	route_id int FOREIGN KEY REFERENCES [routes](id)not null, --некластеризованный индекс
	stop_id int FOREIGN KEY REFERENCES stopping(id) not null, --некластеризованный индекс
	[time] time not null,
	km float not null
)

CREATE NONCLUSTERED INDEX NT_route_id
ON routes_stopping(route_id)
CREATE NONCLUSTERED INDEX NT_stop_id
ON routes_stopping(stop_id)


create table ticket
(
	id INT PRIMARY KEY IDENTITY(1,1) NOT NULL, --кластеризованный индекс
	creat_date datetime2 NOT NULL,
	pass_id int FOREIGN KEY REFERENCES passengers(id) not null,
	ttable_id int FOREIGN KEY REFERENCES timetable(id) not null, --некластеризованный индекс
	stop_id int FOREIGN KEY REFERENCES stopping(id),
	car_id int FOREIGN KEY REFERENCES cars(id) not null,
	seats_id int not null, --некластеризованный индекс
	price float not null
	
)

CREATE NONCLUSTERED INDEX NT_seats_id
ON ticket(seats_id)
CREATE NONCLUSTERED INDEX NT_ttable_id
ON ticket(ttable_id)

create table structure
(
	id INT PRIMARY KEY IDENTITY(1,1) NOT NULL, --кластеризованный индекс
	creat_date datetime2 NOT NULL,
	train_id int FOREIGN KEY REFERENCES trains(id) not null, --некластеризованный индекс
	car_id int FOREIGN KEY REFERENCES cars(id) not null, --некластеризованный индекс
	[status] varchar(1) not null --некластеризованный индекс
)

CREATE NONCLUSTERED INDEX NT_train_id
ON structure(train_id)
CREATE NONCLUSTERED INDEX NT_car_id
ON structure(car_id)
CREATE NONCLUSTERED INDEX NT_status
ON structure([status])

create table timetable
(
	id INT PRIMARY KEY IDENTITY(1,1) NOT NULL, --кластеризованный индекс
	creat_date datetime2 NOT NULL,
	train_id int FOREIGN KEY REFERENCES trains(id) not null, --некластеризованный индекс
	route_id int FOREIGN KEY REFERENCES [routes](id) not null, --некластеризованный индекс
	flight_date date NOT NULL --некластеризованный индекс
)

CREATE NONCLUSTERED INDEX NT_train_id
ON timetable(train_id)
CREATE NONCLUSTERED INDEX NT_route_id
ON timetable(route_id)
CREATE NONCLUSTERED INDEX NT_flight_date
ON timetable(flight_date)


create table pay
(
	id INT PRIMARY KEY IDENTITY(1,1) not null, --кластеризованный индекс
	creat_date datetime2 NOT NULL,
	ticket_id int FOREIGN KEY REFERENCES ticket(id) not null, --некластеризованный индекс
	condition bit not null --некластеризованный индекс
)

CREATE NONCLUSTERED INDEX NT_ticket_id
ON pay(ticket_id)
CREATE NONCLUSTERED INDEX NT_condition
ON pay(condition)
