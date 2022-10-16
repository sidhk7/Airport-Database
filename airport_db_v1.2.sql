
--use first_db


--drop database airport_new
create database airport_new
go
use airport_new

------------------------------------------------------------------------------>

-- 1] COUNTRY

CREATE TABLE COUNTRY
(country_id TINYINT,
country_name varchar(40) NOT NULL,
PRIMARY KEY (country_id))

INSERT INTO COUNTRY
         	(country_id, country_name)
VALUES (1, 'India'), (2, 'United States of America'),(3, 'England'),(4,'France')

--select * from COUNTRY

------------------------------------------------------------------------------>

-- 2] STATE

CREATE TABLE STATE
(state_id TINYINT,
state_name varchar(40) NOT NULL,
country_id TINYINT,
PRIMARY KEY (state_id),
FOREIGN KEY (country_id) REFERENCES country(country_id))
 
INSERT INTO STATE
         	(state_id, state_name,country_id)
VALUES (1,'Haryana',1), (2, 'Punjab',1),(3, 'New York',2),(4,'Essex',3),(5,'Paris Region',4), 
(6,'Maharashtra',1), (7,'Gujarat',1), (8,'Tamil Nadu',1), (9,'New Delhi',1)



--select * from STATE

------------------------------------------------------------------------------>

-- 3] CITY

CREATE TABLE CITY
(city_id TINYINT,
city_name varchar(40) NOT NULL,
state_id TINYINT,
PRIMARY KEY (city_id),
FOREIGN KEY (state_id) REFERENCES state(state_id))
 
INSERT INTO CITY
         	(city_id, city_name,state_id)
VALUES (1,'Amritsar',2), (2, 'Gurugram',1),(3, 'New York',3),(4,'New Jersey',3),(5,'Paris',4)

INSERT INTO CITY
         	(city_id, city_name,state_id)
VALUES (6,'Mumbai',6), (7, 'Ahmedabad',7),(8, 'Chennai',8),(9,'Delhi',9)

--select * from CITY

------------------------------------------------------------------------------>

-- 4] DEPARTMENT

CREATE TABLE DEPARTMENT
(dept_id char(2),
dept_name varchar(40) NOT NULL,
PRIMARY KEY (dept_id))
 
INSERT INTO DEPARTMENT
         	(dept_id, dept_name)
VALUES ('CL', 'Cleaning'),('IM','Immigration'), ('CU','Custom')

--select * from DEPARTMENT

-------------------------------------------------------------------------------->

-- 5] MANAGER

CREATE TABLE MANAGER
(manager_id int,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30),
working_years int,
PRIMARY KEY (manager_id))

INSERT INTO MANAGER
         	(manager_id, first_name, last_name, working_years)
VALUES (1, 'MS', 'Dhoni', 8),
(2,'Rohit','Sharma',6),
(3,'Virat','Kohli',4)


------------------------------------------------------------------------------>

-- 6] EMPLOYEE

CREATE TABLE EMPLOYEE
(employee_id int,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30),
date_of_birth DATETIME,
date_of_joining DATETIME,
city_id TINYINT,
dept_id char(2),
manager_id int,
PRIMARY KEY (employee_id),
FOREIGN KEY (city_id) REFERENCES CITY(city_id),
FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id),
FOREIGN KEY (manager_id) REFERENCES MANAGER(manager_id))
 
INSERT INTO EMPLOYEE
         	(employee_id, first_name, last_name, date_of_birth, date_of_joining, city_id, dept_id, manager_id)
VALUES (1, 'MS', 'Dhoni', '19900618 10:34:09 AM', '20180618 10:34:09 AM', 1, 'CL', NULL),
(2,'Rohit','Sharma','19910618 10:34:09 AM','20190301 10:34:09 AM',2,'CU',1),
(3,'Virat','Kohli','19920512 10:34:09 AM','20160910 10:34:09 AM',1,'IM',2),
(4,'Jasprit','Bumrah','19930101 10:34:09 AM','20171125 10:34:09 AM',2,'CU',2),
(5, 'Shikhar', 'Dhawan', '19910505 10:34:09 AM', '20180618 10:34:09 AM', 1, 'IM', 3),
(6,'Rishabh','Pant','19910618 10:34:09 AM','20190301 10:34:09 AM',2,'CU',2),
(7,'Ravindra','Jadeja','19920512 10:34:09 AM','20160910 10:34:09 AM',1,'CL',1),
(8,'KL','Rahul','19930101 10:34:09 AM','20171125 10:34:09 AM',2,'CU',2)

--select * from EMPLOYEE

------------------------------------------------------------------------------>

-- 7] EMPLOYEE_SALARY

CREATE TABLE EMPLOYEE_SALARY
(record_id int,
employee_id int,
dept_id char(2),
salary int,
PRIMARY KEY (record_id),
FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id),
FOREIGN KEY (dept_id) REFERENCES DEPARTMENT(dept_id))

INSERT INTO EMPLOYEE_SALARY
         	(record_id, employee_id, dept_id, salary)
VALUES (1, 1, 'CL', 100000),
(2, 2,'CU',150000),
(3, 3,'IM',700000),
(4, 4,'IM',50000),
(5, 5,'CU',15000)

--select * from EMPLOYEE_SALARY


------------------------------------------------------------------------------>

-- 8] PILOT

CREATE TABLE PILOT 
(pilot_id INT,
employee_id INT,
first_name VARCHAR(45) NOT NULL,
last_Name VARCHAR(45),
contact bigint,
license char(1),
PRIMARY KEY (pilot_id),
FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id))

INSERT INTO PILOT
         	(pilot_id, employee_id, first_name, last_name, contact, license)
VALUES (1, 2, 'Rohit','Sharma', 9895426842, 'y'),
(2, 4,'Jasprit','Bumrah', 9895426842, 'n'),
(4, 3, 'Virat','Kohli', 9895426842, 'y')

--select * from PILOT

------------------------------------------------------------------------------>

-- 9] AIRPORT

CREATE TABLE AIRPORT 
(airport_id INT,
airport_name VARCHAR(100),
city_id TINYINT,
PRIMARY KEY (airport_id),
FOREIGN KEY (city_id) REFERENCES CITY(city_id))

INSERT INTO AIRPORT 
			(airport_id, airport_name, city_id) 
VALUES (1, 'Chhatrapati Shivaji Maharaj International Airport', 6),
(2, 'Sardar Vallabh Bhai Patel International Airport', 7),
(3, 'Chennai International Airport', 8),
(4, 'Guru Ram Dass Jee International Airport', 1),
(5, 'Indira Gandhi International Airport', 9)


------------------------------------------------------------------------------>

-- 10] AIRLINE_TYPE

CREATE TABLE AIRLINE_TYPE
(airline_type_id char(2),
airline_type VARCHAR(45),
PRIMARY KEY (airline_type_id))

INSERT INTO AIRLINE_TYPE (airline_type_id,airline_type) 
VALUES ('FS', 'Full Service'),('LC','Low Cost'),('HC','High Cost')


------------------------------------------------------------------------------>


-- 11] AIRLINE 

CREATE TABLE AIRLINE 
(airline_id INT,
airline_name VARCHAR(45),
airline_type_id char(2),
iata VARCHAR(45),
icao VARCHAR(45),
call_sign VARCHAR(45) ,
commenced INT,
hub int,
PRIMARY KEY (airline_id),
FOREIGN KEY (airline_type_id) REFERENCES AIRLINE_TYPE(airline_type_id),
FOREIGN KEY (hub) REFERENCES AIRPORT(airport_id))

INSERT INTO AIRLINE 
			(airline_id, airline_name, airline_type_id, iata, icao, call_sign, commenced, hub) 
VALUES (1, 'Air India','FS', 'AI', 'AIC', 'AIRINDIA', 1932, 001),
(2, 'IndiGo', 'LC', '6E', 'IGO', 'IFLY', 2006, 005),
(3, 'Jet Airways', 'FS', '9W', 'JAI', 'JET AIRWAYS', 1995, 005),
(4, 'SpiceJet', 'LC', 'SG', 'SEJ', 'SPICEJET', 2005, 005),
(5, 'Vistara', 'FS', 'UK', 'VTI', 'VISTARA', 2015, 005)


------------------------------------------------------------------------------>

-- 12] AIRPLANE


CREATE TABLE AIRPLANE 
(plane_id varchar(5),
airline_id int,
plane_name varchar(45),
model_number int,
capacity int,
weight_kg int,
PRIMARY KEY (plane_id),
FOREIGN KEY (airline_id) REFERENCES AIRLINE(airline_id))

INSERT INTO AIRPLANE
         	(plane_id, airline_id, plane_name, model_number, capacity, weight_kg)
VALUES ('LH297', 5, 'Lufthansa', '788', '200', '50000'),
('MH102', 2, 'Indigo', '753', '180', '41000'),
('MH104', 2, 'Indigo', '760', '180', '42000')


------------------------------------------------------------------------------>

-- 13] TERMINAL

CREATE TABLE TERMINAL 
(terminal_id INT,
terminal_name VARCHAR(45),
airport_id int,
num_gates INT,
PRIMARY KEY (terminal_id),
FOREIGN KEY (airport_id) REFERENCES AIRPORT(airport_id))

INSERT INTO TERMINAL 
			(terminal_id, terminal_name, airport_id, num_gates) 
VALUES (1, 'T2', '1', 6),
(2, 'T3', '1', 4),
(3, 'D5', '5', 10)

--select * from TERMINAL

------------------------------------------------------------------------------>

-- 14] FLIGHT_DETAILS

CREATE TABLE FLIGHT_DETAILS 
(flight_id INT,
plane_id varchar(5),
origin tinyint,
destination tinyint,
dept_time DATETIME,
arrival_time DATETIME,
duration INT,
flight_status VARCHAR(45),
PRIMARY KEY (flight_id),
FOREIGN KEY (plane_id) REFERENCES AIRPLANE(plane_id),
FOREIGN KEY (origin) REFERENCES CITY(city_id),
FOREIGN KEY (destination) REFERENCES CITY(city_id))

INSERT INTO FLIGHT_DETAILS
         	(flight_id, plane_id, origin, destination, dept_time, arrival_time, duration, flight_status)
VALUES (1, 'LH297', 1,2, '20210618 10:34:09 AM', '20210618 12:35:00 PM', 2, 'Boarding'),
(2, 'MH102', 4,5, '20210711 11:00:00 AM', '20210711 13:30:00 PM', 2.5, 'Delayed'),
(3, 'MH104', 3,1, '20210818 06:20:00 AM', '20210818 07:20:00 PM', 1, 'Scheduled');

--SELECT * FROM FLIGHT_DETAILS

------------------------------------------------------------------------------>

-- 15] TRAFFIC_CONTROLLER

CREATE TABLE TRAFFIC_CONTROLLER 
(controller_ID INT,
equipment_id int,
airport_ID INT,
contact BIGINT,
PRIMARY KEY (controller_ID),
FOREIGN KEY (airport_id) REFERENCES AIRPORT(airport_id))

INSERT INTO TRAFFIC_CONTROLLER 
			(controller_ID, equipment_id, airport_id, contact) 
VALUES (1, 2, 002, 8462572562),
(2, 3, 002, 7561478625),
(3, 1, 001, 9968522477),
(4, 3, 001, 8988754621)

--select * from TRAFFIC_CONTROLLER

------------------------------------------------------------------------------>

-- 16] PASSENGER_DETAILS

CREATE TABLE PASSENGER_DETAILS
(passenger_id INT,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
gender CHAR(1) NOT NULL,
passport_id CHAR(8) NOT NULL UNIQUE,
aadhar CHAR(12) NOT NULL UNIQUE,
city_id TINYINT NOT NULL,
PRIMARY KEY (passenger_id),
FOREIGN KEY (city_id) REFERENCES CITY(city_id))
  
INSERT INTO PASSENGER_DETAILS
         	(passenger_id, first_name, last_name, gender, passport_id, aadhar, city_id)
VALUES (10001, 'Cristiano', 'Ronaldo', 'M', 'H1234567', '123456789123', 1),
(10002,'Lionel','Messi','M','H1234568','123456789124',2),
(10003,'Mohammed','Salah','M','H1234569','123456789125',3),
(10004,'Kevin','DeBruyne','M','H1234570','123456789126',3),
(10005,'Harry','Kane','M','H1234571','123456789127',1),
(10006,'Virgil','VanDijk','M','H1234572','123456789128',4),
(10007,'Kylian','Mbappe','M','H1234573','123456789129',5),
(1008,'Neymar','Junior','M','H1234574','123456789130',5)

--select * from PASSENGER_DETAILS

------------------------------------------------------------------------------>

-- 17] BOOKING

CREATE TABLE BOOKING 
(booking_id INT NOT NULL,
passenger_id INT,
from_airport int,
to_airport int,
amount int,
confirm_status varchar(30),
PRIMARY KEY (booking_id),
FOREIGN KEY (passenger_id) REFERENCES PASSENGER_DETAILS(passenger_id),
FOREIGN KEY (from_airport) REFERENCES AIRPORT(airport_id),
FOREIGN KEY (to_airport) REFERENCES AIRPORT(airport_id))
  
INSERT INTO BOOKING 
			(booking_id, passenger_id, from_airport, to_airport, amount, confirm_status) 
VALUES (101, 10001, 5, 2, 4500, 'confirmed'),
(102, 1008, 1, 4, 4500, 'confirmed'),
(103, 10005, 1, 3, 5000, 'cancelled'),
(104, 10004, 2, 3, 4500, 're-booked'),
(105, 10003, 4, 5, 4000, 'confirmed'),
(106, 10002, 5, 1, 6000, 'cancelled'),
(107, 10006, 1, 2, 3500, 're-booked'),
(108, 1008, 5, 3, 7700, 'confirmed')

--select * from BOOKING

------------------------------------------------------------------------------>

-- 18] PASSENGER_SCHEDULE

CREATE TABLE PASSENGER_SCHEDULE
(schedule_id INT,
passenger_id INT,
departure_from int,
departure_time varchar(30),
arrival_to int,
arrival_time varchar(30),
booking_id INT,
PRIMARY KEY (schedule_id),
FOREIGN KEY (passenger_id) REFERENCES PASSENGER_DETAILS(passenger_id),
FOREIGN KEY (departure_from) REFERENCES TERMINAL(terminal_id),
FOREIGN KEY (arrival_to) REFERENCES TERMINAL(terminal_id),
FOREIGN KEY (booking_id) REFERENCES BOOKING(booking_id))

INSERT INTO PASSENGER_SCHEDULE
         	(schedule_id, passenger_id, departure_from, departure_time, arrival_to, arrival_time, booking_id)
VALUES
(9001, 10001, 1, '20220710 10:34:09 AM', 2, '20220710 10:34:09 AM', 101),
(9002, 10004, 3, '20210710 11:34:09 AM', 2, '20210710 13:34:09 AM', 104),
(9003,10007,2,'20220710 10:34:09 AM',1,'20220710 13:34:09 AM',102),
(9004,10002,2,'20220711 10:34:09 AM',3,'20220711 13:34:09 AM',105),
(9005,1008,1,'20220711 10:34:09 AM',2,'20220711 13:34:09 AM',103),
(9006,10003,3,'20220712 10:34:09 AM',1,'20220712 13:34:09 AM',104),
(9007,10001,1,'20220713 10:34:09 AM',3,'20220713 13:34:09 AM',104),
(9008,10001,2,'20220713 10:34:09 AM',1,'20220713 13:34:09 AM',101)

--select * from PASSENGER_SCHEDULE

------------------------------------------------------------------------------>

-- 18] IMMIGRATION_STATUS

CREATE TABLE IMMIGRATION_STATUS
(status_id  CHAR(1),
status_desc VARCHAR(20) ,
PRIMARY KEY(status_id))
 
INSERT INTO IMMIGRATION_STATUS
         	(status_id, status_desc)
VALUES ('A', 'Accepted'),('R','Rejected'),('P','Pending')

--select * from IMMIGRATION_STATUS

------------------------------------------------------------------------------>

-- 19] IMMIGRATION_PURPOSE

CREATE TABLE IMMIGRATION_PURPOSE
(purpose_id  CHAR(1),
purpose_desc VARCHAR(20) NOT NULL,
PRIMARY KEY(purpose_id))
 
 INSERT INTO IMMIGRATION_PURPOSE
         	(purpose_id, purpose_desc)
VALUES ('T', 'Tourist'),('B','Business'),('M','Medical'),('G','Government')

--select * from IMMIGRATION_PURPOSE

------------------------------------------------------------------------------>

-- 20] IMMIGRATION

 CREATE TABLE IMMIGRATION
(row_id  INT,
employee_id int NOT NULL,
schedule_id INT NOT NULL,
date_of_arrival DATETIME DEFAULT current_timestamp NOT NULL,
status_id CHAR(1) NOT NULL,
purpose_id CHAR(1) NOT NULL,
PRIMARY KEY (row_id),
FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id),
FOREIGN KEY (status_id) REFERENCES IMMIGRATION_STATUS(status_id),
FOREIGN KEY (purpose_id) REFERENCES IMMIGRATION_PURPOSE(purpose_id),
FOREIGN KEY (schedule_id) REFERENCES PASSENGER_SCHEDULE(SCHEDULE_ID))

INSERT INTO immigration
         	(row_id, employee_id, schedule_id, date_of_arrival, status_id, purpose_id)
VALUES (1, 4, 9001, '20220710 10:34:09 AM', 'A', 'B'),
(2,4,9002,'20220711 10:34:09 AM','P','T'),
(3,4,9003,'20220712 10:34:09 AM','A','G'),
(4,4,9004,'20220712 11:45:09 AM','R','M')

--select * from IMMIGRATION

------------------------------------------------------------------------------>

-- 21] CUSTOM_STATUS

CREATE TABLE CUSTOM_STATUS
(check_status CHAR(2),
status_desc VARCHAR(30),
PRIMARY KEY (check_status))
 
INSERT INTO CUSTOM_STATUS
         	(check_status, status_desc)
VALUES ('AP', 'Approved'),('IL','Illegal Firearms') , ('NA','Narcotics'),('GO','Gold')

--select * from CUSTOM_STATUS

------------------------------------------------------------------------------>

-- 22] CUSTOM_STATUS_CHECK

CREATE TABLE CUSTOM_STATUS_CHECK
(row_id INT,
employee_id INT NOT NULL,
schedule_id INT NOT NULL,
check_status CHAR(2) NOT NULL,
PRIMARY KEY (row_id),
FOREIGN KEY (check_status) REFERENCES CUSTOM_STATUS(check_status),
FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(employee_id))
 
INSERT INTO CUSTOM_STATUS_CHECK
       	(row_id, employee_id, schedule_id, check_status)
VALUES (1, 2, 9001, 'AP'),(2,4,9002,'IL'),(3,4,9003,'AP'),(4,6,9004,'NA'),(5,6,9005,'GO'),(6,2,9006,'AP')

--select * from CUSTOM_STATUS_CHECK

------------------------------------------------------------------------------>

-- 23] LUGGAGE_BELTS

CREATE TABLE LUGGAGE_BELTS
(belt_id INT,
belt_name varchar(20) NOT NULL,
airport_id INT NOT NULL,
PRIMARY KEY (belt_id),
FOREIGN KEY (airport_id) REFERENCES AIRPORT(airport_id))

INSERT INTO luggage_belts
         	(belt_id, belt_name, airport_id)
VALUES (1, 'A', 5),(2,'B',1),(3,'C',4),(4,'D',1),(5,'E',1),(6,'Alpha',2),(7,'Beta',3),(8,'Gama',2),(9,'Theta',3)

--select * from luggage_belts

------------------------------------------------------------------------------>

-- 24] ARRIVAL_DEPARTURE

CREATE TABLE ARRIVAL_DEPARTURE
(row_id INT,
plane_id varchar(5) NOT NULL,
dep_from_terminal INT NOT NULL,
departure_time DATETIME NOT NULL,
arr_to_terminal INT NOT NULL,
arrival_time DATETIME NOT NULL,
belt_id INT NOT NULL,
PRIMARY KEY (row_id),
FOREIGN KEY (plane_id) REFERENCES AIRPLANE(plane_id),
FOREIGN KEY (belt_id) REFERENCES LUGGAGE_BELTS(belt_id),
FOREIGN KEY (dep_from_terminal) REFERENCES TERMINAL(terminal_id),
FOREIGN KEY (arr_to_terminal) REFERENCES TERMINAL(terminal_id))
 
INSERT INTO ARRIVAL_DEPARTURE
         	(row_id, plane_id, dep_from_terminal, departure_time, arr_to_terminal, arrival_time, belt_id)
VALUES (1, 'LH297', 1, '20220712 10:34:09 AM', 2, '20220712 12:50:09 AM', 1),
(2,'MH102',2,'20220711 10:34:09 AM', 3,'20220711 05:34:09 PM',2),
(3,'MH104',3,'20220712 11:50:09 AM', 1,'20220712 14:12:09 PM',5)

--select * from ARRIVAL_DEPARTURE

------------------------------------------------------------------------------>

-- 25] ATC_EQUIPMENT

CREATE TABLE ATC_EQUIPMENT
(equipment_id TINYINT,
equipment_name VARCHAR(40),
PRIMARY KEY (equipment_id))
 
INSERT INTO ATC_EQUIPMENT (equipment_id,equipment_name) 
VALUES (1, 'Radar'),(2,'Navigation'),(3,'Communications')

--select * from ATC_EQUIPMENT

------------------------------------------------------------------------------>

-- 26] ADVERTISEMENT_SIZE

CREATE TABLE ADVERTISEMENT_SIZE
(slot_size_id VARCHAR(10),
size_sq_ft INT NOT NULL
PRIMARY KEY(slot_size_id))
 
INSERT INTO ADVERTISEMENT_SIZE (slot_size_id,size_sq_ft) VALUES
('SMALL', 128),('MEDIUM',256),('LARGE',512)

--select * from ADVERTISEMENT_SIZE

------------------------------------------------------------------------------>

-- 27] ADVERTISEMENT_CATEGORY

CREATE TABLE ADVERTISEMENT_CATEGORY
(slot_price_category VARCHAR(10),
price INT NOT NULL
PRIMARY KEY(slot_price_category))
 
INSERT INTO ADVERTISEMENT_CATEGORY (slot_price_category,price) VALUES
('BUDGET', 50000),('PREMIUM',100000),('LUXURY',250000)

--select * from ADVERTISEMENT_CATEGORY

------------------------------------------------------------------------------>

-- 28] AIRPORT_ADVERTISEMENT_SPACE

CREATE TABLE AIRPORT_ADVERTISEMENT_SPACE
(slot_id INT,
airport_id INT NOT NULL,
slot_size_id VARCHAR(10) NOT NULL,
slot_price_category VARCHAR(10) NOT NULL,
PRIMARY KEY (slot_id),
FOREIGN KEY (airport_id) REFERENCES AIRPORT(airport_id),
FOREIGN KEY (slot_size_id) REFERENCES ADVERTISEMENT_SIZE(slot_size_id),
FOREIGN KEY (slot_price_category) REFERENCES ADVERTISEMENT_CATEGORY(slot_price_category))
 
INSERT INTO AIRPORT_ADVERTISEMENT_SPACE (slot_id,airport_id,slot_size_id,slot_price_category)
VALUES (4005,1,'LARGE','PREMIUM'),(4006,3,'SMALL','BUDGET'),(4007,2,'MEDIUM','LUXURY')

--select * from AIRPORT_ADVERTISEMENT_SPACE

------------------------------------------------------------------------------>

-- 29] RETAIL_CATEGORY

CREATE TABLE RETAIL_CATEGORY
(outlet_category varchar(30),
price_per_month int NOT NULL,
PRIMARY KEY (outlet_category))
  
INSERT INTO RETAIL_CATEGORY
         	(outlet_category, price_per_month)
VALUES ('BUDGET', 100000),('PREMIUM',250000),('RICHIE RICH',500000)

--select * from RETAIL_CATEGORY

------------------------------------------------------------------------------>

-- 30] AIRPORT_RETAIL_OUTLETS

CREATE TABLE AIRPORT_RETAIL_OUTLETS
(outlet_id int,
terminal_id int NOT NULL,
outlet_category varchar(30) NOT NULL,
PRIMARY KEY (outlet_id),
FOREIGN KEY (terminal_id) REFERENCES TERMINAL(terminal_id),
FOREIGN KEY (outlet_category) REFERENCES RETAIL_CATEGORY(outlet_category)
)
 
INSERT INTO AIRPORT_RETAIL_OUTLETS
         	(outlet_id, terminal_id, outlet_category)
VALUES (7001, 1, 'PREMIUM'),
(7002,2,'RICHIE RICH'),
(7003,3,'BUDGET'),
(7004,3,'RICHIE RICH')
 
--select * from AIRPORT_RETAIL_OUTLETS

------------------------------------------------------------------------------>

-- 31] CABIN_CREW

CREATE TABLE CABIN_CREW	
(crew_id int,
employee_id int,
airline_id int,
contact bigint,
desgination varchar(30),
PRIMARY KEY (crew_id))

INSERT INTO CABIN_CREW
         	(crew_id, employee_id, airline_id, contact, desgination)
VALUES (1, 1, 2, 8475623551, 'steward'),
(2, 4, 3,5841554451, 'pilot'),
(3, 5, 3,9966885541, 'airhostess'),
(4, 2, 3,9633021550, 'pilot')

--select * from CABIN_CREW

------------------------------------------------------------------------------>

-- 32] ROUTE

CREATE TABLE ROUTE 
(route_id INT NOT NULL,
flight_id INT,
from_airport int,
to_airport int,
distance_km INT,
PRIMARY KEY (route_id),
FOREIGN KEY (flight_id) REFERENCES FLIGHT_DETAILS(flight_id),
FOREIGN KEY (from_airport) REFERENCES AIRPORT(airport_id),
FOREIGN KEY (to_airport) REFERENCES AIRPORT(airport_id))

INSERT INTO ROUTE
         	(route_id, flight_id, from_airport, to_airport, distance_km)
VALUES (1, 1, 2, 5, 1000),
(2, 2, 1, 3, 500),
(3, 3, 3, 4, 750)

--select * from ROUTE

------------------------------------------------------------------------------>

-- 33] SCHEDULE

CREATE TABLE SCHEDULE (
schedule_id int NOT NULL,
flight_id INT ,
airline_id int,
terminal_id int,
departure DATETIME NULL,
arrival DATETIME NULL,
PRIMARY KEY (schedule_id),
FOREIGN KEY (flight_id) REFERENCES FLIGHT_DETAILS(flight_id),
FOREIGN KEY (airline_id) REFERENCES AIRLINE(airline_id),
FOREIGN KEY (terminal_id) REFERENCES TERMINAL(terminal_id))

INSERT INTO SCHEDULE
         	(schedule_id, flight_id, airline_id, terminal_id, departure, arrival)
VALUES (1, 1, 2, 2,'20220712 10:34:09 AM', '20220712 12:50:09 AM'),
(2,2,4,3, '20220711 10:34:09 AM','20220711 05:34:09 PM'),
(3,3,5,1, '20220712 11:50:09 AM','20220712 14:12:09 PM')

--select * from SCHEDULE

------------------------------------------------------------------------------>

-- 34] SEAT_CLASS

CREATE TABLE SEAT_CLASS 
(class_id char(2) NOT NULL,
class VARCHAR(45),
price int,
 PRIMARY KEY (class_id))

 INSERT INTO SEAT_CLASS
         	(class_id, class, price)
VALUES ('FC', 'First Class', 250000),
('UE', 'Upper Economy', 7000),
('LE', 'Lower Economy', 4500),
('BC', 'Business Class', 30000)

------------------------------------------------------------------------------>

-- 35] TICKET

CREATE TABLE TICKET 
(ticket_id INT NOT NULL,
booking_id int,
airline_id int NULL,
seat_num VARCHAR(45) NULL,
class_id char(2) NULL,
PRIMARY KEY (ticket_id),
FOREIGN KEY (class_id) REFERENCES SEAT_CLASS(class_id),
)

INSERT INTO TICKET
         	(ticket_id, booking_id, airline_id, seat_num, class_id)
VALUES (1, 101, 2, '3A', 'FC'),
(2, 104, 1, '35C', 'UE'),
(3, 105, 1, '40B', 'UE'),
(4, 108, 2, '10B', 'BC')

--select * from TICKET

------------------------------------------------------------------------------>

-- 36] PARKING

CREATE TABLE PARKING 
(parking_id int NOT NULL,
passenger_id int,
allowed_duration_mins int,
charges int,
 PRIMARY KEY (parking_id),
 FOREIGN KEY (passenger_id) REFERENCES PASSENGER_DETAILS(passenger_id))

INSERT INTO PARKING
         	(parking_id, passenger_id, allowed_duration_mins, charges)
VALUES (1, 10001, 50, 100),
(2, 10004, 300, 500),
(3, 10005, 20, 50),
(4, 1008, 100, 250)

--select * from PARKING

------------------------------------------------------------------------------>

-- 37] GATES

CREATE TABLE GATES 
(gate_id char(3) NOT NULL,
terminal_id int,
 PRIMARY KEY (gate_id),
 FOREIGN KEY (terminal_id) REFERENCES TERMINAL(terminal_id))

INSERT INTO GATES
         	(gate_id, terminal_id)
VALUES ('a1',1), ('a2',1), ('a3',1), ('a4',1), ('a5',1), ('a6',1),
('b1',2), ('b2',2), ('b3',2), ('b4',2),
('c1',3), ('c2',3), ('c3',3), ('c4',3), ('c5',3), ('c6',3), ('c7',3), ('c8',3), ('c9',3), ('c10',3)

------------------------------------------------------------------------------>

-- 38] BOARDING_PASS

CREATE TABLE BOARDING_PASS 
(pass_id INT NOT NULL,
passenger_id INT,
flight_id INT,
gate_id char(3),
has_checked_in TINYINT,
has_boarded TINYINT,
num_of_bags int,
meal VARCHAR(45),
PRIMARY KEY (pass_id),
FOREIGN KEY (passenger_id) REFERENCES PASSENGER_DETAILS(passenger_id),
FOREIGN KEY (flight_id) REFERENCES FLIGHT_DETAILS(flight_id),
FOREIGN KEY (gate_id) REFERENCES GATES(gate_id))

INSERT INTO BOARDING_PASS
         	(pass_id, passenger_id, flight_id, gate_id,has_checked_in,has_boarded, num_of_bags,meal)
VALUES (1, 10001, 1, 'c7',1,0,1,'veg'),
(2, 10004, 2, 'a5',1,0,2,'nonveg'),
(3, 10005, 3, 'b4',1,1,3,'veg'),
(4, 1008, 2, 'a6',1,0,4,'veg')

--select * from BOARDING_PASS


------------------------------------------------------------------------------>


ALTER TABLE traffic_controller ALTER COLUMN equipment_id TINYINT

ALTER TABLE traffic_controller ADD CONSTRAINT equipment_fk FOREIGN KEY (equipment_id) REFERENCES atc_equipment(equipment_id)



ALTER TABLE traffic_controller ALTER COLUMN equipment_id TINYINT

ALTER TABLE traffic_controller ADD FOREIGN KEY (equipment_id) REFERENCES atc_equipment(equipment_id)

ALTER TABLE CABIN_CREW ADD FOREIGN KEY (airline_id) REFERENCES airline(airline_id)

ALTER TABLE TICKET ADD  FOREIGN KEY (booking_id) REFERENCES booking(booking_id)

update BOARDING_PASS set meal = null

ALTER TABLE BOARDING_PASS ALTER COLUMN meal TINYINT

update BOARDING_PASS set meal = 3 where pass_id in (1,4)
update BOARDING_PASS set meal = 1 where pass_id = 2
update BOARDING_PASS set meal = 2 where pass_id = 3

update EMPLOYEE_SALARY set dept_id = 'CU' where employee_id = 4
update EMPLOYEE_SALARY set dept_id = 'IM' where employee_id = 5

Insert into EMPLOYEE_SALARY (record_id,employee_id,dept_id,salary) values (6,6,'CU',40000),(7,7,'CL',100000),(8,8,'CU',50000)

update employee_salary set salary = '90000' where employee_id = 3
------------------------------------------------------------------------------>

-- 39] MEAL_DESC

CREATE TABLE MEAL_DESC (
meal_id TINYINT,
meal_desc VARCHAR(15),
PRIMARY KEY (meal_ID))

INSERT INTO MEAL_DESC (meal_id,meal_desc) VALUES (1,'Veg'),(2,'Non Veg'),(3,'Hindu Non Veg')

ALTER TABLE BOARDING_PASS ADD FOREIGN KEY (meal) REFERENCES MEAL_DESC(meal_id)


------------------------------------------------------------------------------>

-- 40] CAB_AGGREGATORS_NAMES

CREATE TABLE CAB_AGGREGATORS_NAMES (
CAB_AGGREGATOR TINYINT,
NAME_TEXT VARCHAR(15),
PRIMARY KEY (CAB_AGGREGATOR))

INSERT INTO CAB_AGGREGATORS_NAMES (CAB_AGGREGATOR,NAME_TEXT) VALUES 
(1,'UBER'), (2,'OLA'),(3,'MERU')



--------------------------------------------------------------------------------->

-- 41] CAB_AGGREGATORS

CREATE TABLE CAB_AGGREGATORS (
AGGREGATOR_ID TINYINT,
CAB_AGGREGATOR TINYINT,
AIRPORT_ID INT,
CREATION_DATE DATETIME DEFAULT current_timestamp,
PRIMARY KEY (AGGREGATOR_ID),
FOREIGN KEY (AIRPORT_ID) REFERENCES AIRPORT(AIRPORT_ID),
FOREIGN KEY (CAB_AGGREGATOR) REFERENCES CAB_AGGREGATORS_NAMES(CAB_AGGREGATOR))

INSERT INTO CAB_AGGREGATORS (AGGREGATOR_ID,CAB_AGGREGATOR,AIRPORT_ID) VALUES 
(1,1,1), (2,2,1),(3,3,1),(4,1,2),(5,2,2)