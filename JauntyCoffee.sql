-- creating a database for Jaunty Coffee Co. 
-- populating data in each table created. 

CREATE TABLE Coffee_shop (
shop_id	INTEGER,
shop_name	VARCHAR(50),
city	VARCHAR(50),
state	CHAR(2),
PRIMARY KEY (shop_id)
);

INSERT INTO Coffee_shop (shop_id, shop_name, city, state)
VALUES (5001,'Bennu','Austin','TX'),
       (5002,'Aroma','San Marcos','CA'),
       (5003,'Razza','San Antonio','AZ'),
       (5004,'Gorilla Café','Jarrel','TX'),
       (5005,'Guanzu coffee','Leander','CO');
       

CREATE TABLE Coffee (
coffee_id	INTEGER,
PRIMARY KEY (coffee_id),
shop_id	INTEGER,
FOREIGN KEY (shop_id) references Coffee_shop (shop_id),
supplier_id	INTEGER,
FOREIGN KEY (supplier_id) references Supplier (supplier_id),
coffee_name	VARCHAR(30),
price_per_pound	NUMERIC(2,2)
);

INSERT INTO Coffee (coffee_id, shop_id, supplier_id, coffee_name, price_per_pound)
VALUES (1101,5001,1201,'dark roasted',2.99),
       (1102,5002,1202,'medium beans',1.3),
       (1103,5003,1203,'moca java', 4.16),
       (1104,5004,1204,'grounded',1.5),
       (1105,5005,1205,'arabia',2.29);

CREATE TABLE Supplier (
supplier_id	INTEGER,
PRIMARY KEY (supplier_id),
company_name	VARCHAR(50),
country	VARCHAR(30),
sales_contact_name	VARCHAR(60),
email	VARCHAR(50)
);

INSERT INTO Supplier (supplier_id, company_name, country, sales_contact_name, email)
VALUES (1201,'Rwanda Mountain coffee','Rwanda','Belise Earl','b.earl@rmc.rw'),
       (1202,'coffee supply inc.','USA','Felix Mob','f.mob@coffeesupplyinc.com'),
       (1203,'great beans','USA','Mary Goldbridge','m.goldbrige@gbeans.com'),
       (1204,'fresh aroma inc.','MEXICO','Francis Moreno','f.moreno@faroma.com'),
       (1205,'raw coffee supply inc.','UK','Gabby Emmerson','g.emmerson@rawcoffee.com');
       
-- verifying data in all tables       

SELECT *
FROM Supplier;

SELECT *
FROM Coffee;

SELECT *
FROM Coffee_shop;

SELECT employee_id, concat(first_name,' ', last_name) as fullname, hire_date, job_title, shop_id
FROM Employee;

USE  JauntyCoffee 

CREATE TABLE Employee
( employee_id INT PRIMARY KEY,
first_name VARCHAR(30),
last_name VARCHAR(30),
hire_date DATE, 
job_title VARCHAR(30),
shop_id INT,
FOREIGN KEY (shop_id) references Coffee_shop(shop_id)
)

INSERT INTO Employee 
VALUES (1001,'Tony', 'Jenkins', '2008-12-01','manager', 5001),
	   (1002, 'Railey','Johns', '2009-03-20', 'cook', 5002),
       (1003, 'Tom', 'Bansley', '2011-05-21','server', 5003),
       (1004, 'Jean', 'Jardon','2008-01-15', 'cook', 5004),
       (1005, 'Eddy','Ngira','2008-01-16', 'dishwasher', 5005)


/* creating a view to show all informationl from Employee table with concantenate each employee's first 
and last name.
*/
USE JauntyCoffee

CREATE VIEW EmployeeView
AS SELECT employee_id, concat(first_name, ' ', last_name) as employee_fullname, hire_date, job_title, shop_id
   FROM Employee


SELECT *
FROM EmployeeView

-- creating index on the coffee_name field from the “Coffee” table.

USE JauntyCoffee

CREATE INDEX coffee_name_idx
ON Coffee (coffee_name)

USE JauntyCoffee

SELECT first_name, last_name, hire_date, job_title
FROM Employee
WHERE employee_id = 1004

-- The query should join together three different tables and include attributes from all three tables in its output.

SELECT *
FROM Coffee_shop, Employee, Coffee
WHERE Coffee_shop.shop_id = Employee.shop_id
      AND Coffee_shop.shop_id = Coffee.shop_id

