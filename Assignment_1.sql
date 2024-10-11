create database telcox;
use telcox;

CREATE TABLE telcox.cities (
	CityID int not null auto_increment primary key, 
	Name varchar(60) not null,
	Population int not null,
	Mean_Income decimal(6,1) not null
    );    
INSERT INTO telcox.cities (Name, Population, Mean_Income)
VALUES
    ('Athens', 664046, 18900),
    ('Thessaloniki', 325182, 17200),
    ('Patras', 167446, 15600),
    ('Heraklion', 173993, 16800),
    ('Larissa', 162591, 16200),
    ('Volos', 144449, 15900),
    ('Ioannina', 112486, 14900);

CREATE TABLE telcox.customers (
	CustomerID int not null auto_increment primary key,
	First_Name varchar(60) not null,
    Last_Name varchar(60) not null,
    Date_of_birth DATE not null,
    Gender varchar(8) not null,
    CITY_ID int, 
	foreign key (CITY_ID)
		references telcox.cities(CityID),
    check(Gender in('Male', 'Female'))
    );
INSERT INTO telcox.customers (First_Name, Last_Name, Date_of_birth, Gender, CITY_ID)
VALUES
    ('Nikos', 'Papadopoulos', '1988-07-20', 'Male', 2),
    ('Maria', 'Koutroumpis', '1995-03-12', 'Female', 2),
    ('Giorgos', 'Papadakis', '1990-11-05', 'Male', 3),
    ('Eleni', 'Katsarou', '1983-09-15', 'Female', 4),
    ('Dimitris', 'Tassis', '1998-04-30', 'Male', 5),
    ('Vasiliki', 'Karagianni', '1992-01-18', 'Female', 6),
    ('Panagiotis', 'Pappas', '1980-12-08', 'Male', 3);

CREATE TABLE telcox.plan (
	PlanID INT not null primary key,
    Plan_Name VARCHAR(30) not null,
    FreeSMS INT not null check (FreeSMS > 0),
    FreeMinutes INT not null check (FreeMinutes > 0),
    FreeMB INT not null check(FreeMB > 0)
	);
INSERT INTO telcox.plan (PlanID, Plan_Name, FreeSMS, FreeMinutes, FreeMB)
VALUES
    (1, 'Basic Plan', 100, 500, 600),
    (2, 'Standard Plan', 200, 1000, 1200),
    (3, 'Premium Plan', 300, 1500, 2600);

CREATE TABLE telcox.contract(
	ContractID int not null auto_increment primary key,
    PhoneNumber int not null unique,
    Description varchar(60) not null,
    Start_Date date not null,
    End_Date date not null,
    Customer_ID int not null,
    foreign key(Customer_ID)
		references telcox.customers(CustomerID),
	Plan_ID int not null,
    foreign key(Plan_ID)
		references telcox.plan(PlanID)
	);

INSERT INTO telcox.contract (PhoneNumber, Description, Start_Date, End_Date, Customer_ID, Plan_ID)
VALUES
    (693123456, 'Contract 1', '2022-01-01', '2023-12-31', 1, 1),
    (694987654, 'Contract 2', '2022-02-15', '2024-02-14', 2, 2),
    (695555555, 'Contract 3', '2022-03-10', '2023-09-10', 3, 3),
    (697111122, 'Contract 4', '2022-04-20', '2024-04-19', 4, 1),
    (694333344, 'Contract 5', '2022-06-05', '2023-12-05', 5, 2),
    (698555566, 'Contract 6', '2022-07-15', '2024-07-14', 6, 3),
    (699777788, 'Contract 7', '2022-09-01', '2024-08-31', 7, 1);


CREATE TABLE telcox.calls(
	CallID INT not null primary key auto_increment,
    CalledNumber INT not null,
    Duration_In_Seconds INT not null,
    Date_of_Call DATETIME not null,
    ContractID INT not null,
		foreign key(ContractID)
			references telcox.contract(ContractID)
	);
INSERT INTO telcox.calls (CalledNumber, Duration_In_Seconds, Date_of_Call, ContractID)
VALUES
    (694987654, 300, '2022-01-05 10:30:00', 1),
    (695555555, 180, '2022-02-20 15:45:00', 2),
    (693123457, 420, '2022-04-12 08:00:00', 3),
    (697111122, 240, '2022-06-18 12:30:00', 4),
    (694333344, 360, '2022-08-02 20:15:00', 5),
    (698555566, 480, '2022-09-20 09:45:00', 6),
    (699777788, 600, '2022-11-10 14:00:00', 7),
    (699777788, 25, '2022-06-20 08:30:00', 7),
    (698555570, 68, '2022-06-20 09:30:00', 5),
    (698555570, 20, '2022-06-25 09:30:00',5),
    (693123465, 15, '2022-06-23 09:00:00',3);

SELECT CallID
FROM calls
WHERE Date_of_Call BETWEEN '2022-06-01 08:00:00' AND '2022-06-30 10:00:00'
AND Duration_In_Seconds<30;

select * from telcox.calls;
INSERT INTO telcox.cities (Name, Population, Mean_Income)
VALUES 
	('Alexandroupoli', 15000, 8000),
    ('Rethymno', 18000, 14000);
INSERT INTO telcox.customers (First_Name, Last_Name, Date_of_birth, Gender, CITY_ID)
VALUES
	('Giannis', 'Dimitriadis', '1968-02-21','Male', 8),
    ('Katerina', 'Kazaki', '1975-05-18', 'Female',9);

-- Task 3b
select * from plan;
SELECT First_Name, Last_Name
FROM customers
WHERE CITY_ID IN(
	SELECT CityID
    FROM cities
    WHERE Population>20000);
-- Task 3b end --

INSERT into plan(PlanID, Plan_Name, FreeSMS, FreeMinutes, FreeMB)
	VALUES(4, 'FreedomONE Plan', 300, 500, 1500);
INSERT INTO telcox.contract (PhoneNumber, Description, Start_Date, End_Date, Customer_ID, Plan_ID)
VALUES
	(697053748, 'Freedom Contract','2021-07-25', '2023-12-31', 3, 4),
	(697053769, 'Freedom Contract','2021-03-15', '2023-12-31', 6, 4);

-- Task 3c --
SELECT CustomerID
FROM customers
WHERE CustomerID IN(
	SELECT Customer_ID
    FROM contract
    WHERE Plan_ID IN(
		SELECT PlanID
        FROM plan
        WHERE Plan_Name LIKE '%Freedom%'));
-- Task 3c end --

SELECT * FROM customers;
INSERT INTO telcox.contract (PhoneNumber, Description, Start_Date, End_Date, Customer_ID, Plan_ID)
VALUES
    (696666666, 'Contract 10', '2023-09-20', '2023-11-19', 7, 1),
    (695555587, 'Contract 11', '2023-08-05', '2023-09-04', 8, 2);

SELECT c.ContractID, c.PhoneNumber, c.Customer_ID, cust.First_Name, cust.Last_Name
FROM contract c
JOIN customers cust ON c.Customer_ID = cust.CustomerID
WHERE datediff(End_Date, curdate())<60
ORDER BY c.ContractID;

select * from contract;
-- task 3f
SELECT p.PlanID, sum(cl.Duration_In_Seconds) as 'Total Duration in Seconds'
FROM calls cl 
JOIN contract con ON cl.ContractID = con.ContractID
JOIN plan p ON p.PlanID = con.Plan_ID
WHERE year(cl.Date_of_call) = 2022
group by p.PlanID;

-- task 3f end

INSERT INTO telcox.calls (CalledNumber, Duration_In_Seconds, Date_of_Call, ContractID)
VALUES
	(698555570, 500, '2022-09-23 09:00:00', 5),
    (695478968, 740, '2022-07-15 06:00:00', 4),
    (698555570, 620, '2022-10-15 06:00:00',4),
    (694568913, 850, '2022-07-15 06:00:00',5),
    (698555570, 1200, '2022-07-12 00:00:00',1),
    (694568913, 1500, '2022-07-12 18:00:00',1),
    (697852345, 678, '2022-05-23 00:00:00', 3);

-- Task 3g
SELECT CalledNumber,
count(*) as call_counter
FROM calls
WHERE year(Date_of_call) = 2022
GROUP BY CalledNumber
HAVING count(*) = ( SELECT max(count)
					FROM (
                    SELECT count(*) AS count
                    FROM calls
					WHERE year(Date_of_call) = 2022
					GROUP BY CalledNumber
                    ) AS finding_max
                    );
					
                    
-- task 3e
SELECT con.ContractID, month(cl.Date_of_call) as 'Month of Call', round(avg(cl.Duration_In_Seconds),1) as 'Average Duration(in seconds)'
FROM contract con
JOIN calls cl ON con.ContractID = cl.ContractID
WHERE year(Date_of_call) = 2022
GROUP BY con.ContractID, month(cl.Date_of_call)
ORDER BY con.ContractID asc, month(cl.Date_of_call) asc;
-- task 3e end

select * from plan;
SELECT * from calls;
UPDATE plan
SET FreeMinutes=15
WHERE PlanID=1;
UPDATE calls
SET Date_of_Call = '2022-10-13'
WHERE CallID=13;


-- Task 3h
SELECT con.ContractID, month(cl.Date_of_Call) as 'Month', sum(cl.Duration_In_Seconds) as 'Total Duration(seconds)', p.FreeMinutes
FROM calls cl
JOIN contract con ON con.ContractID = cl.ContractID
JOIN plan p ON con.Plan_ID = p.PlanID
WHERE year(cl.Date_of_Call) =2022
GROUP BY con.ContractID, month(cl.Date_of_call)
HAVING sum(cl.Duration_In_Seconds) > p.FreeMinutes*60
ORDER BY con.ContractID asc, month(cl.Date_of_Call) asc;

-- Task 3h end

-- ALTER TABLE calls MODIFY CallID INT AUTO_INCREMENT --
select * from cities;
INSERT INTO telcox.calls (CalledNumber, Duration_In_Seconds, Date_of_Call, ContractID)
VALUES
    (694987654, 300, '2021-01-15 09:45:00', 1),
    (695555555, 180, '2021-02-25 14:20:00', 2),
    (693123456, 420, '2021-03-10 08:30:00', 3),
    (697111122, 240, '2021-04-18 11:15:00', 4),
    (694333344, 360, '2021-05-05 18:45:00', 5),
    (698555566, 480, '2021-06-15 12:00:00', 6),
    (699777888, 600, '2021-07-22 16:30:00', 7),
    (694986543, 300, '2021-08-08 09:00:00', 1),
    (695555555, 180, '2021-09-20 14:45:00', 2),
    (693234567, 420, '2021-10-12 08:15:00', 3),
    (697111222, 240, '2021-11-18 11:30:00', 4),
    (694333444, 360, '2021-12-05 18:00:00', 5),
    (694976543, 300, '2021-04-05 10:30:00', 1),
    (695555555, 180, '2021-04-15 14:20:00', 2),
    (691234567, 420, '2021-04-25 08:30:00', 3),
    (697111222, 240, '2021-06-10 11:15:00', 4),
    (694333444, 360, '2021-06-20 18:45:00', 5),
    (698555566, 480, '2021-06-30 12:00:00', 6),
    (699777788, 600, '2021-09-08 16:30:00', 7),
    (694987543, 300, '2021-09-15 09:00:00', 1),
    (695555555, 180, '2021-09-25 14:45:00', 2),
    (693134567, 420, '2021-10-05 08:15:00', 3),
    (691211222, 240, '2021-10-18 11:30:00', 4),
    (694333444, 360, '2021-10-28 18:00:00', 5);
INSERT INTO telcox.calls (CalledNumber, Duration_In_Seconds, Date_of_Call, ContractID)
VALUES
(694333344, 360, '2022-03-05 18:45:00', 5),
(698555566, 480, '2022-12-15 12:00:00', 6);
select * from calls where month(Date_of_Call)=10;
SELECT year(Date_of_Call) as 'Year', month(Date_of_Call) as 'Month', round((sum(Duration_In_Seconds)-
LAG(sum(Duration_In_Seconds), 12) OVER(ORDER BY year(Date_of_Call), month(Date_of_Call)))/
LAG(sum(Duration_In_Seconds), 12) OVER(ORDER BY year(Date_of_Call), month(Date_of_Call))*100,2) as 'Change of the total call Duration (as percentage)'
FROM calls
GROUP BY year(Date_of_Call), month(Date_of_Call)
ORDER BY year(Date_of_Call) desc, month(Date_of_Call) asc;



-- Task 3j --
SELECT c.CityID,
    coalesce(round(AVG(CASE WHEN cust.Gender = 'Female' THEN cl.Duration_In_Seconds END), 2),0) as 'Avg Call Duration of Women',
    coalesce(round(AVG(CASE WHEN cust.Gender = 'Male' THEN cl.Duration_In_Seconds END), 2),0) as 'Avg Call Duration of Men'
FROM calls cl
JOIN contract con ON cl.ContractID = con.ContractID
JOIN customers cust ON con.Customer_ID = cust.CustomerID
JOIN cities c ON cust.CITY_ID = c.CityID
WHERE YEAR(cl.Date_of_Call) = 2022
GROUP BY c.CityID;

update customers
set First_Name = 'Panagiota', Last_Name = 'Pappa'
where CustomerID = 7;
update calls 
set ContractID = 10
where CallID = 77;
-- task 3j end--

-- task 3k--
select * from calls;

SELECT 
    CITY.CityID,
    (SELECT SUM(cl.Duration_In_Seconds) 
     FROM calls cl
     JOIN telcox.contract co ON cl.ContractID = co.ContractID
     JOIN telcox.customers cu ON co.Customer_ID = cu.CustomerID
     JOIN telcox.cities c ON cu.CITY_ID = c.CityID
     WHERE YEAR(cl.Date_of_Call) = 2022 AND CITY.CityID = c.CityID) AS TotalDurationForCity,
    (SELECT SUM(cl2.Duration_In_Seconds) FROM calls cl2 WHERE YEAR(cl2.Date_of_Call) = 2022) AS TotalDurationAllCities,
    CITY.Population,
    (SELECT SUM(Population) FROM cities) AS TotalPopulation
FROM telcox.cities AS CITY;

SELECT 
    c2.CityID,
    COALESCE((SELECT SUM(cl.Duration_In_Seconds) 
              FROM calls cl
              JOIN contract con ON cl.ContractID = con.ContractID
              JOIN customers cust ON con.Customer_ID = cust.CustomerID
              JOIN cities c ON cust.CITY_ID = c.CityID
              WHERE YEAR(cl.Date_of_Call) = 2022 AND c2.CityID = c.CityID), 0) /
    (SELECT SUM(cl2.Duration_In_Seconds) FROM calls cl2 WHERE YEAR(cl2.Date_of_Call) = 2022) AS 'Call Duration Ratio',
    c2.Population / (SELECT SUM(Population) FROM cities) AS 'Population Ratio'
FROM cities AS c2;

-- Task 3k End--