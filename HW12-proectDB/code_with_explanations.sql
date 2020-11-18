/*������� routes � stopping ��������� �������� ������� � ����� ������� routes_stopping, ��� ��� ������� ����� ����������� �� ��������� �� �������� �����, ���� �� ��������� ����� �� ���������, ����������� ��� ���������, � ������������ � ���� ������������� ���� ������*/

-- ************************************** [cars]

CREATE TABLE [cars] --�����
(
 [id]      int NOT NULL , --id ������
 [dadd]    datetime NOT NULL , --���� ���������� ������
 [seats]   int NOT NULL , --���������� ���� � ������
 [type_id] int NOT NULL , --id ���� ������


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

CREATE TABLE [cars_type] --��� ������
(
 [id]            int NOT NULL , --id ������
 [dadd]          datetime NOT NULL , --���� ���������� ������
 [type]          varchar(60) NOT NULL , --��� ������
 [service_class] varchar(20) NOT NULL , --����� ������������
 [min_seats]     int NOT NULL , --����������� ���������� ���� � ������
 [max_seats]     int NOT NULL , --������������ ���������� ���� � ������
 [markup]        float NOT NULL , --������� �� ����� ������������+��� ������


 CONSTRAINT [PK_cars_type] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO

-- ************************************** [passengers]

CREATE TABLE [passengers] --��������
(
 [id]          int NOT NULL , --id ���������
 [dadd]        datetime NOT NULL , --���� ���������� ������
 [first_name]  varchar(20) NOT NULL , --���
 [middle_name] varchar(20) NOT NULL , --��������
 [last_name]   varchar(20) NOT NULL , --�������
 [birthday]    date NOT NULL , --���� ��������
 [passport]    bigint NOT NULL , --������ ��������
 [phone]       varchar(20) NOT NULL , --����� ��������
 [email]       varchar(30) NOT NULL , --�����


 CONSTRAINT [PK_passengers] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO

-- ************************************** [pay]

CREATE TABLE [pay] --������ ������ ������
(
 [id]        int NOT NULL , --id ������
 [dadd]      datetime NOT NULL , --���� ���������� ������
 [condition] bit NOT NULL , --������ ������ ������
 [ticket_id] int NOT NULL , --id ������


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

CREATE TABLE [routes] --�������
(
 [id]          int NOT NULL , --id ��������
 [dadd]        datetime NOT NULL , --���� ���������� ������
 [beg_time]    time(7) NOT NULL , --����� ������ ����
 [end_time]    time(7) NOT NULL , --����� ��������� ����
 [duration]    varchar(70) NOT NULL , --����� � ����
 [distance]    float NOT NULL , --������������ ����
 [price_100km] float NOT NULL , --���� �� ��������
 [price_place] float NOT NULL , --���� �� �����
 [bed_point]   int NOT NULL , --��������� �����
 [end_point]   int NOT NULL , --�������� �����


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

CREATE TABLE [routes_stopping] --���������
(
 [id]       int NOT NULL , --id ���������
 [dadd]     datetime NOT NULL , --���� ���������� ������
 [time]     time(7) NOT NULL , --����� �������� �� ���������
 [km]       float NOT NULL , --��������� �� ���������
 [stop_id]  int NOT NULL , --id ���������
 [route_id] int NOT NULL , --id ����


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

CREATE TABLE [stopping] --���������
(
 [id]    int NOT NULL , --id ���������
 [dadd]  datetime NOT NULL , --���� ���������� ������
 [title] varchar(30) NOT NULL , --�������� ���������


 CONSTRAINT [PK_stopping] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO

-- ************************************** [structure]

CREATE TABLE [structure] --������ ������
(
 [id]       int NOT NULL , --id ���������
 [dadd]     datetime NOT NULL , --���� ���������� ������
 [status]   varchar(1) NOT NULL , --������ ������
 [train_id] int NOT NULL , --id ������
 [car_id]   int NOT NULL , --id ������


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

CREATE TABLE [ticket] --�����
(
 [id]        int NOT NULL , --id ������
 [dadd]      datetime NOT NULL , --���� ���������� ������
 [seats_id]  int NOT NULL , --id �����
 [price]     float NOT NULL , --���� ������
 [pass_id]   int NOT NULL , --id ���������
 [stop_id]   int NULL , --id ���������
 [ttable_id] int NOT NULL , --id ����������
 [car_id]    int NOT NULL , --id ������


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

CREATE TABLE [timetable] --����������
(
 [id]          int NOT NULL , --id ����������
 [dadd]        datetime NOT NULL , --���� ���������� ������
 [flight_date] date NOT NULL , --���� �����������
 [train_id]    int NOT NULL , --id ������
 [route_id]    int NOT NULL , --id ����


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

CREATE TABLE [trains] --�����
(
 [id]     int NOT NULL , --id ������
 [dadd]   datetime NOT NULL , --���� ���������� ������
 [number] varchar(10) NOT NULL , --����� ������
 [cars]   int NOT NULL , --������
 [m_id]   int NOT NULL , --id ������ ������


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

CREATE TABLE [trains_model] --������ ������
(
 [id]     int NOT NULL , --id ������
 [dadd]   datetime NOT NULL , -- ���� ���������� ������
 [title]  varchar(50) NOT NULL , --�������� ������
 [type]   varchar(50) NOT NULL , --��� ������
 [markup] float NOT NULL , --������� �� ��� ������


 CONSTRAINT [PK_trains_model] PRIMARY KEY CLUSTERED ([id] ASC)
);
GO