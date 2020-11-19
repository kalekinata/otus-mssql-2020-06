/*Таблицы routes и stopping соединены внешними ключами и через таблицу routes_stopping, так как маршрут может указываться от начальной до конечной точки, либо от начальной точки до остановки, необходимой для пассажира, с соответствии с этим высчитывается цена билета*/

-- ************************************** [cars]

CREATE TABLE [cars] --Вагон
(
 [id]      int NOT NULL , --id вагона
 [dadd]    datetime NOT NULL , --дата добавления записи
 [seats]   int NOT NULL , --количество мест в вагоне
 [type_id] int NOT NULL , --id типа вагона


 CONSTRAINT [PK_cars] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_type_id] FOREIGN KEY ([type_id])  REFERENCES [cars_type]([id])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_type_id] ON [cars] 
 (
  [type_id] ASC
 )

GO

-- ************************************** [cars_type]

CREATE TABLE [cars_type] --тип вагона
(
 [id]            int NOT NULL , --id вагона
 [dadd]          datetime NOT NULL , --дата добавления записи
 [type]          varchar(60) NOT NULL , --тип вагона
 [service_class] varchar(20) NOT NULL , --класс обслуживания
 [min_seats]     int NOT NULL , --минимальное количество мест в вагоне
 [max_seats]     int NOT NULL , --максимальное количество мест в вагоне
 [markup]        float NOT NULL , --наценка за класс обслуживания+тип вагона


 CONSTRAINT [PK_cars_type] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO

-- ************************************** [passengers]

CREATE TABLE [passengers] --пассажир
(
 [id]          int NOT NULL , --id пассажира
 [dadd]        datetime NOT NULL , --дата добавления записи
 [first_name]  varchar(20) NOT NULL , --имя
 [middle_name] varchar(20) NOT NULL , --отчество
 [last_name]   varchar(20) NOT NULL , --фамилия
 [birthday]    date NOT NULL , --дата рождения
 [passport]    bigint NOT NULL , --данные паспорта
 [phone]       varchar(20) NOT NULL , --номер телефона
 [email]       varchar(30) NOT NULL , --почта


 CONSTRAINT [PK_passengers] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO

-- ************************************** [pay]

CREATE TABLE [pay] --статус оплаты билета
(
 [id]        int NOT NULL , --id билета
 [dadd]      datetime NOT NULL , --дата добавления записи
 [condition] bit NOT NULL , --статус оплаты билета
 [ticket_id] int NOT NULL , --id билета


 CONSTRAINT [PK_pay] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_ticket_id] FOREIGN KEY ([ticket_id])  REFERENCES [ticket]([id])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_ticket_id] ON [pay] 
 (
  [ticket_id] ASC
 )

GO

-- ************************************** [routes]

CREATE TABLE [routes] --маршрут
(
 [id]          int NOT NULL , --id маршрута
 [dadd]        datetime NOT NULL , --дата добавления записи
 [beg_time]    time(7) NOT NULL , --время начала пути
 [end_time]    time(7) NOT NULL , --время окончания пути
 [duration]    varchar(70) NOT NULL , --время в пути
 [distance]    float NOT NULL , --протяжённость пути
 [price_100km] float NOT NULL , --цена за километр
 [price_place] float NOT NULL , --цена за место
 [bed_point]   int NOT NULL , --начальная точка
 [end_point]   int NOT NULL , --конечная точка


 CONSTRAINT [PK_routes] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_end_point] FOREIGN KEY ([end_point])  REFERENCES [stopping]([id]),
 CONSTRAINT [FK_bed_point] FOREIGN KEY ([bed_point])  REFERENCES [stopping]([id])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_end_point] ON [routes] 
 (
  [end_point] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_bed_point] ON [routes] 
 (
  [bed_point] ASC
 )

GO

-- ************************************** [routes_stopping]

CREATE TABLE [routes_stopping] --остановка
(
 [id]       int NOT NULL , --id остановки
 [dadd]     datetime NOT NULL , --дата добавления записи
 [time]     time(7) NOT NULL , --время прибытия на остановку
 [km]       float NOT NULL , --дистанция до остановки
 [stop_id]  int NOT NULL , --id остановки
 [route_id] int NOT NULL , --id пути


 CONSTRAINT [PK_routes_stopping] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_stop_id] FOREIGN KEY ([stop_id])  REFERENCES [stopping]([id]),
 CONSTRAINT [FK_route_id] FOREIGN KEY ([route_id])  REFERENCES [routes]([id])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_stop_id] ON [routes_stopping] 
 (
  [stop_id] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_route_id] ON [routes_stopping] 
 (
  [route_id] ASC
 )

GO

-- ************************************** [stopping]

CREATE TABLE [stopping] --остановка
(
 [id]    int NOT NULL , --id остановка
 [dadd]  datetime NOT NULL , --дата добавления записи
 [title] varchar(30) NOT NULL , --название остановки


 CONSTRAINT [PK_stopping] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO

-- ************************************** [structure]

CREATE TABLE [structure] --состав поезда
(
 [id]       int NOT NULL , --id остановки
 [dadd]     datetime NOT NULL , --дата добавления записи
 [status]   varchar(1) NOT NULL , --статус вагона
 [train_id] int NOT NULL , --id поезда
 [car_id]   int NOT NULL , --id вагона


 CONSTRAINT [PK_structure] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_train_id] FOREIGN KEY ([train_id])  REFERENCES [trains]([id]),
 CONSTRAINT [FK_car_id] FOREIGN KEY ([car_id])  REFERENCES [cars]([id])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_train_id] ON [structure] 
 (
  [train_id] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_car_id] ON [structure] 
 (
  [car_id] ASC
 )

GO

-- ************************************** [ticket]

CREATE TABLE [ticket] --билет
(
 [id]        int NOT NULL , --id билета
 [dadd]      datetime NOT NULL , --дата добавления записи
 [seats_id]  int NOT NULL , --id места
 [price]     float NOT NULL , --цена билета
 [pass_id]   int NOT NULL , --id пассажира
 [stop_id]   int NULL , --id остановки
 [ttable_id] int NOT NULL , --id расписания
 [car_id]    int NOT NULL , --id вагона


 CONSTRAINT [PK_ticket] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_pass_id] FOREIGN KEY ([pass_id])  REFERENCES [passengers]([id]),
 CONSTRAINT [FK_stop_id] FOREIGN KEY ([stop_id])  REFERENCES [stopping]([id]),
 CONSTRAINT [FK_ttable_id] FOREIGN KEY ([ttable_id])  REFERENCES [timetable]([id]),
 CONSTRAINT [FK_car_id] FOREIGN KEY ([car_id])  REFERENCES [cars]([id])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_pass_id] ON [ticket] 
 (
  [pass_id] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_stop_id] ON [ticket] 
 (
  [stop_id] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_ttable_id] ON [ticket] 
 (
  [ttable_id] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_car_id] ON [ticket] 
 (
  [car_id] ASC
 )

GO

-- ************************************** [timetable]

CREATE TABLE [timetable] --расписание
(
 [id]          int NOT NULL , --id расписания
 [dadd]        datetime NOT NULL , --дата добавления записи
 [flight_date] date NOT NULL , --дата отправления
 [train_id]    int NOT NULL , --id поезда
 [route_id]    int NOT NULL , --id пути


 CONSTRAINT [PK_timetable] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_train_id] FOREIGN KEY ([train_id])  REFERENCES [trains]([id]),
 CONSTRAINT [FK_route_id] FOREIGN KEY ([route_id])  REFERENCES [routes]([id])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_train_id] ON [timetable] 
 (
  [train_id] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_route_id] ON [timetable] 
 (
  [route_id] ASC
 )

GO

-- ************************************** [trains]

CREATE TABLE [trains] --поезд
(
 [id]     int NOT NULL , --id поезда
 [dadd]   datetime NOT NULL , --дата добавления записи
 [number] varchar(10) NOT NULL , --номер поезда
 [cars]   int NOT NULL , --вагоны
 [m_id]   int NOT NULL , --id модели вагона


 CONSTRAINT [PK_trains] PRIMARY KEY CLUSTERED ([id] ASC),
 CONSTRAINT [FK_m_id] FOREIGN KEY ([m_id])  REFERENCES [trains_model]([id])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_m_id] ON [trains] 
 (
  [m_id] ASC
 )

GO

-- ************************************** [trains_model]

CREATE TABLE [trains_model] --модель поезда
(
 [id]     int NOT NULL , --id модели
 [dadd]   datetime NOT NULL , -- дата добавления записи
 [title]  varchar(50) NOT NULL , --название вагона
 [type]   varchar(50) NOT NULL , --тип вагона
 [markup] float NOT NULL , --наценка за тип вагона


 CONSTRAINT [PK_trains_model] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO
