CREATE TABLE EmployeeDemographics
(EmployeeID int, 
Firstname varchar(50),
Lastname varchar(50),
Age int,
Gender varchar(50)
)

CREATE TABLE EmployeeSalary
(EmployeeID int,
JobTitle varchar(50),
Salary int
)

INSERT INTO EmployeeDemographics 
VALUES (1002, 'Pam','Beasley', 30, 'Female'),
	   (1003,'Dwight','Schrute', 29, 'Male'),
       (1004,'Angela','Martin', 31, 'Female'),
	   (1005,'Toby','Flenderson', 32, 'Male'),
	   (1006,'Michael','Scott', 35, 'Male'),
       (1007,'Meredith','Palmer', 32, 'Female'),
       (1008,'Stanley','Hudson', 38, 'Male'),
       (1009,'Kevin','Malone', 31, 'Male')

INSERT INTO EmployeeSalary 
VALUES (1001, 'Salesman', 45000),
	   (1002, 'Receptionist', 36000),
       (1003, 'Salesman', 63000),
       (1004, 'Accountant', 47000),
       (1005, 'HR', 50000),
       (1006, 'Regional Manager', 65000),
       (1007, 'Supplier Relations', 41000),
       (1008, 'Salesman', 48000),
       (1009, 'Accountant', 42000)
       
/* Select statement
*, Top, Distinct, Count, AS, MAX, MIN, AVG
*/

SELECT DISTINCT (EmployeeID)
FROM EmployeeDemographics;

SELECT DISTINCT (Gender)
FROM EmployeeDemographics;

SELECT count(Lastname) AS LastnameCount
FROM EmployeeDemographics;

SELECT MAX(Salary)
FROM EmployeeSalary

SELECT AVG(Salary)
FROM EmployeeSalary

/* WHERE statement
*, Top, Distinct, Count, AS, MAX, MIN, AVG
*/

SELECT *
FROM EmployeeDemographics
WHERE Age <= 32 AND Gender = 'Male'


SELECT *
FROM EmployeeDemographics
WHERE Age <= 32 OR Gender = 'Male'

SELECT *
FROM EmployeeDemographics
WHERE Lastname LIKE '%S%'


SELECT *
FROM EmployeeDemographics
WHERE FirstName is NOT NULL


SELECT *
FROM EmployeeDemographics
WHERE Firstname IN ('Jim','Michael')

/* 
Group By, Order By statement
*/

SELECT Gender, count(Gender) AS CountGender
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender
ORDER BY CountGender 

SELECT *
FROM EmployeeDemographics
ORDER BY Age DESC, Gender DESC

/* INTERMIDIATE SQL SERIES
Inner Joins, Full/left/Right/outer Joins
*/

SELECT *
FROM SQLProject.EmployeeDemographics;

SELECT *
FROM SQLProject.EmployeeSalary;

SELECT *
FROM SQLProject.EmployeeDemographics
INNER JOIN SQLProject.EmployeeSalary
  ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

-- USE CASE where the highest earner is not MICHAEL

SELECT EmployeeDemographics.EmployeeID, Firstname, Lastname, Salary
FROM SQLProject.EmployeeDemographics
INNER JOIN SQLProject.EmployeeSalary
  ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE Firstname <> 'Michael'
ORDER BY Salary DESC

-- Calculating average salary of the salesman
SELECT Jobtitle, AVG(Salary)
FROM SQLProject.EmployeeDemographics
INNER JOIN SQLProject.EmployeeSalary
  ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle

/*
UNION, UNION ALL - very close to join statements.
*/

SELECT *
FROM SQLProject.EmployeeDemographics;

SELECT *
FROM SQLProject.EmployeeSalary;

-- Check the outer join
/* union comes into play when data in different tables have # data types
yet you want to combine both tables.*/

SELECT *
FROM SQLProject.EmployeeDemographics
INNER JOIN SQLProject.EmployeeSalary
  ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
 
 -- UNION Combines both tables without dublicates, works as distinct.
 
SELECT EmployeeID, Firstname, Age
FROM SQLProject.EmployeeDemographics;
UNION ALL
SELECT EmployeeID, JobTitle, Salary
FROM SQLProject.EmployeeSalary;
ORDER BY EmployeeID

/* A Case statement helps to specify a condition and what results to return when that
condition is met
-- CASE STATEMENT */

SELECT  Firstname, Lastname, Age,
CASE
    WHEN Age > 30 THEN 'OLD'
    ELSE 'YOUNG'
END AS AgeGroup
FROM SQLProject.EmployeeDemographics
ORDER BY Age

SELECT *
FROM SQLProject.EmployeeDemographics;

SELECT *
FROM SQLProject.EmployeeSalary;


SELECT Firstname, Lastname, JobTitle, Salary,
CASE
    WHEN JobTitle = 'Salesman' THEN Salary + (Salary *.10)
    WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
    WHEN JobTitle = 'HR' THEN Salary + (Salary * .001)
    ELSE Salary + (Salary * .03)
END AS SalaryAfterRaise
FROM SQLProject.EmployeeDemographics
JOIN SQLProject.EmployeeSalary
  ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

/* Having Clause */
SELECT JobTitle, count(JobTitle) 
FROM SQLProject.EmployeeDemographics
JOIN SQLProject.EmployeeSalary
  ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING count(JobTitle) > 1

SELECT JobTitle, AVG(Salary) 
FROM SQLProject.EmployeeDemographics
JOIN SQLProject.EmployeeSalary
  ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 40000
ORDER BY AVG(Salary) 

/* INSERT - creates a new row in your table
UPDATE - Alters a pre-existing row.
DELETE- Specifies what row to delete in your table */

SELECT *
FROM SQLProject.EmployeeDemographics

UPDATE SQLProject.EmployeeDemographics
SET Age = 31, Gender = 'Female'
WHERE EmployeeID = 1004

DELETE FROM SQLProject.EmployeeDemographics
WHERE EmployeeID = 1001

/* Aliasing- AS */

SELECT Firstname + ' ' + Lastname AS Fullname
FROM SQLProject.EmployeeDemographics

SELECT Demo.EmployeeID, Sal.Salary
FROM SQLProject.EmployeeDemographics as Demo
JOIN SQLProject.EmployeeSalary AS Sal
  ON Demo.EmployeeID = Sal.EmployeeID
  
/* PARTITION BY - oftenly compared by GROUP BY of which group by- combines the number of rows
partition by divides the results into different windows */

SELECT Firstname, Lastname, Gender, Salary
  count(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM SQLProject.EmployeeDemographics Demo
JOIN SQLProject.EmployeeSalary Sal
  ON Demo.EmployeeID = Sal.EmployeeID

SELECT Gender, COUNT(Gender)
FROM SQLProject.EmployeeDemographics Demo
JOIN SQLProject.EmployeeSalary Sal
  ON Demo.EmployeeID = Sal.EmployeeID
GROUP BY Gender

/*Advanced SQL
CTE- Common Table Expression- temporary result set used to manupelate a subqueries data. 
it is only created in memory.
*/

WITH CTE_Employee as 
(SELECT Firstname, Lastname, Gender, Salary
  count(Gender) OVER (PARTITION BY Gender) AS TotalGender
  AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
FROM SQLProject.EmployeeDemographics Demo
JOIN SQLProject.EmployeeSalary Sal
  ON Demo.EmployeeID = Sal.EmployeeID
WHERE Salary > '40000'
)

/*
creating Temp Tables
*/

USE SQLProject

Create table temp_employee
( employeeID int, 
jobtitle varchar(100),
salary int
)
select *
from temp_employee

INSERT INTO temp_employee VALUES (
'1001', 'HR', '45000'
)

INSERT INTO temp_employee -- insert a large number of data into an empty table using SELECT Statement
SELECT *
FROM SQLProject.EmployeeSalary

DROP TABLE IF EXISTS tempEmployee2
create table tempEmployee2(
jobtitle varchar (50),
employeesperJob int,
AvgAge int,
AvgSalary int
)

insert into tempEmployee2
select JobTitle, count(JobTitle), Avg(age), avg(Salary)
from SQLProject.EmployeeDemographics
join SQLProject.EmployeeSalary
  ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
group by JobTitle

select *
from tempEmployee2

/* string functions- TRIM, LTRIM, RTRIM, Replace, substring, Upper, Lower*/
-- Drop Table EmployeeErros;

create table EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

insert into EmployeeErrors Values
('1001 ', 'Jimbo', 'Halbert')
,(' 1002','Pamela', 'Beasely')
,('1005', 'TOby','Flenderson - Fired')

select *
from EmployeeErrors

-- using Trim, RTRIM, LTRIM

select EmployeeID, TRIM(EmployeeID) AS IDTRIM
from EmployeeErrors

select EmployeeID, LTRIM(EmployeeID) AS IDTRIM
from EmployeeErrors

select EmployeeID, RTRIM(EmployeeID) AS IDTRIM
from EmployeeErrors

-- using Replace
select LastName, REPLACE(LastName, '- Fired','') as LastNameFixed
from EmployeeErrors

-- using substring. it can be used for a fazzy match using join

select SUBSTRING(FirstName,3,3)
from EmployeeErrors

-- Upper or Lower

select FirstName, LOWER(FirstName)
from EmployeeErrors

select FirstName, UPPER(FirstName)
from EmployeeErrors

/* STORED PROCEDURES
assignment: figure out how to use store procedures in MySQL Workbench 8.0.30*/
use SQLProject

CREATE PROCEDURE Test ()

   select*
   from EmployeeDemographics
   


USE SQLProject

/* Subqueries ( in the select, from, and where statement)
it is used to return data that will be used in the main query from specified data we want to be 
retrieved.
*/

Select *
from EmployeeSalary

-- subquery in select statement
select EmployeeID, Salary, (select AVG(Salary) from EmployeeSalary) as avgsalary
from EmployeeSalary

-- subquery in from statement
select a.EmployeeID, avgsalary
from (select EmployeeID, Salary, (select AVG(Salary) from EmployeeSalary) as avgsalary
      from EmployeeSalary) a
      
-- subquery in where statement
select EmployeeID, JobTitle, Salary
from EmployeeSalary
where EmployeeID IN (
            select EmployeeID
            from EmployeeDemographics
            where Age > 30)