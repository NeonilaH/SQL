1. [Homework Part 1 -  CREATE TABLE, INSERT  INTO, ALTER TABLE](#1)
2. [Homework Part 2 - SELECT, JOIN](#2)

### **1. Homework Part 1 -  CREATE TABLE, INSERT  INTO, ALTER TABLE**<a name="1"><a>
CREATE TABLE employees77(
	id SERIAL PRIMARY KEY,
	employee_name VARCHAR(50) NOT NULL);

INSERT  INTO employees77(employee_name)
VALUES ('Jimmy Carter'),
	   ('Jamey Sheridan'),
	   ('Timothy Korol'),
	   ('Donald Trump'),
	   ('William Golding'),
	   ('Barack Obama'),
	   ('Ted Hughes'),
	   ('Doris Lessing'),
	   ('Arina Shelby'),
	   ('Marina Honda'),
	   ('Kimiko Katsuragi'),
	   ('Danish Painter'),
	   ('Man Ray'),
	   ('Bill Clinton'),
	   ('Edward Hopper'),
	   ('Salim Murazi'),
	   ('Paolo Pierro'),
	   ('Sanchez Sukre'),
	   ('Jessica Shilov'),
	   ('Rebecca Jo Morales'),
	   ('Gregory Crewdson'),
	   ('Elena Prutko'),
	   ('Daria Shpiler'),
	   ('Beatrix Dagger'),
	   ('Mike Lazovsky'),
	   ('John Adams'),
	   ('Pheck Cynthia'),
	   ('Sakura Miako'),
	   ('Lio San'),
	   ('Xu Xiao'),
	   ('Shang Huang'),
	   ('Li Mao'),
	   ('Sun Liao'),
	   ('Djeng Ji'),
	   ('Liu Bei'),
	   ('Shin Peng'),
	   ('Hinata Miamoto'),
	   ('Yuki Shimari'),
	   ('Max Jhonson'),
	   ('Alex Anderson'),
	   ('Julie Andrews'),
	   ('Andrew Jackson'),
	   ('Ricky Nelson'),
	   ('George Orwell'),
	   ('Richard Nikson'),
	   ('Michel Henderson'),
	   ('Timur ShibaevJames Monroe'),
	   ('Sasha Red'),
	   ('Jack Jhonson'),
	   ('Jamey Sheridan'),
	   ('Demond Wilson'),
	   ('Thomas Jefferson'),
	   ('Quentin Tarantino'),
	   ('Carrie Fisher'),
	   ('George Washington'),
	   ('Aaron Burr'),
	   ('James Madison'),
	   ('Horatio Alger'),
	   ('Edgar Allan Poe'),
	   ('Emily Dickinson'),
	   ('Nancy Kerrigan'),
	   ('Corey Baker'),
	   ('F. Scott Fitzgerald'),
	   ('Laura Myntti'),
	   ('William Faulkner'),
	   ('Joshua Rikson'),
	   ('Jackson Pollock'),
	   ('John Singer Sargent'),
	   ('Frederic Church'),
	   ('Emily Dickinson');

	  
CREATE TABLE salary77(
	id SERIAL PRIMARY KEY,
	monthly_salary INT NOT NULL);

INSERT  INTO salary77 (monthly_salary)
VALUES (1000),
	   (1100),
	   (1200),
	   (1300),
	   (1400),
	   (1500),
	   (1600),
	   (1700),
	   (1800),
	   (1900),
	   (2000),
	   (2100),
	   (2200),
	   (2300),
	   (2400),
	   (2500);

CREATE TABLE employee_salary77(
	id SERIAL PRIMARY KEY,
	employee_id INT UNIQUE NOT NULL,
	salary_id INT NOT NULL);

INSERT  INTO employee_salary77(employee_id, salary_id)
VALUES (3, 7),
	   (1, 4),
	   (5, 9),
	   (40, 13),
	   (23, 4),
	   (11, 2),
	   (52, 10),
	   (15, 13),
	   (26, 4),
	   (16, 1),
	   (33, 7),
	   (100, 6),
	   (101, 1),
	   (102, 15),
	   (104, 5),
	   (105, 6),
	   (106, 4),
	   (107, 2),
	   (108, 7),
	   (109, 3),
	   (110, 9),
	   (37, 15),
	   (2, 4),
	   (51, 10),
	   (55, 8),
	   (61, 7),
	   (67, 5),
	   (69, 9),
	   (71, 4),
	   (44, 6),
	   (36, 1),
	   (25, 2),
	   (6, 6),
	   (7, 7),
	   (8, 8),
	   (9, 9),
	   (12, 10),
	   (17, 11),
	   (62, 12),
	   (66, 13);

CREATE TABLE roles77 (
		id SERIAL PRIMARY KEY,
		role_name INT UNIQUE NOT NULL);

ALTER TABLE roles77 
ALTER COLUMN role_name TYPE VARCHAR(30);
	
INSERT  INTO roles77(role_name)
VALUES ('Junior Python developer'),
	   ('Middle Python developer'),
	   ('Senior Python developer'),
	   ('Junior Java developer'),
	   ('Middle Java developer'),
	   ('Senior Java developer'),
	   ('Junior JavaScript developer'),
	   ('Middle JavaScript developer'),
	   ('Senior JavaScript developer'),
	   ('Junior Manual QA engineer'),
	   ('Middle Manual QA engineer'),
	   ('Senior Manual QA engineer'),
	   ('Project Manager'),
	   ('Designer'),
	   ('HR'),
	   ('CEO'),
	   ('Sales manager'),
	   ('Junior Automation QA engineer'),
	   ('Middle Automation QA engineer'),
	   ('Senior Automation QA engineer');

CREATE TABLE roles_employee77(
	id SERIAL PRIMARY KEY,
	employee_id INT UNIQUE NOT NULL,
	role_id INT NOT NULL,
	FOREIGN KEY (employee_id) REFERENCES employees77(id),
	FOREIGN KEY (role_id) REFERENCES roles77(id));
		
INSERT  INTO roles_employee77(employee_id, role_id)
VALUES (7, 2),
 	   (20, 4),
 	   (3, 9),
 	   (5, 13),
 	   (23, 4),
 	   (11, 2),
 	   (10, 9),
 	   (22, 13),
 	   (21, 3),
 	   (34, 4),
 	   (6, 7),
 	   (1, 15),
 	   (2, 14),
 	   (4, 1),
 	   (8, 5),
 	   (9, 11),
 	   (12, 12),
 	   (13, 3),
 	   (14, 1),
 	   (15, 12),
 	   (16, 9),
 	   (17, 7),
 	   (18, 8),
 	   (19, 9),
 	   (24, 6),
 	   (25, 5),
 	   (26, 4),
 	   (27, 3),
 	   (28, 2),
 	   (29, 1),
 	   (30, 2),
 	   (31, 3),
 	   (32, 4),
 	   (33, 5),
 	   (35, 6),
 	   (36, 7),
 	   (37, 8),
 	   (38, 9),
 	   (39, 10),
 	   (40, 11);

### **2. Homework Part 2 - SELECT, JOIN**<a name="2"><a>
SELECT e.employee_name, s.monthly_salary 
FROM employees e 
  JOIN employee_salary es ON e.id = es.employee_id 
  JOIN salary s ON es.salary_id = s.id;

SELECT e.employee_name, s.monthly_salary 
FROM employees e 
  JOIN employee_salary es ON e.id = es.employee_id 
  JOIN salary s ON es.salary_id = s.id 
WHERE s.monthly_salary < 2000;

SELECT es.employee_id 
FROM employees e 
  FULL JOIN employee_salary es ON e.id = es.employee_id 
WHERE es.employee_id != e.id 
ORDER BY es.employee_id;

SELECT s.monthly_salary 
FROM employees e 
  FULL JOIN employee_salary es ON e.id = es.employee_id 
  FULL JOIN salary s ON es.salary_id = s.id 
WHERE e.employee_name IS NULL 
ORDER BY s.monthly_salary;
 
SELECT s.monthly_salary 
FROM employees e 
  FULL JOIN employee_salary es ON e.id = es.employee_id 
  FULL JOIN salary s ON es.salary_id = s.id 
WHERE e.employee_name IS NULL AND s.monthly_salary < 2000 
ORDER BY s.monthly_salary;
 
SELECT  e.employee_name, s.monthly_salary
FROM employees e 
  FULL JOIN employee_salary es ON e.id = es.employee_id 
  FULL JOIN salary s ON es.salary_id = s.id 
WHERE s.monthly_salary IS NULL 
ORDER BY e.employee_name;

SELECT e.employee_name, role_name 
FROM employees e 
  JOIN roles_employee re ON e.id = re.employee_id 
  JOIN roles r ON re.role_id = r.id;

SELECT e.employee_name, role_name 
FROM employees e 
  JOIN roles_employee re ON e.id = re.employee_id 
  JOIN roles r ON re.role_id = r.id 
WHERE r.role_name LIKE '%Java developer';

SELECT e.employee_name, role_name 
FROM employees e 
  JOIN roles_employee re ON e.id = re.employee_id 
  JOIN roles r ON re.role_id = r.id 
WHERE r.role_name LIKE '%Python developer';

SELECT e.employee_name, role_name 
FROM employees e 
  JOIN roles_employee re ON e.id = re.employee_id 
  JOIN roles r ON re.role_id = r.id 
WHERE r.role_name LIKE '%QA engineer';

SELECT e.employee_name, role_name 
FROM employees e 
  JOIN roles_employee re ON e.id = re.employee_id 
  JOIN roles r ON re.role_id = r.id 
WHERE r.role_name LIKE '% Manual QA engineer';

SELECT e.employee_name, role_name 
FROM employees e 
  JOIN roles_employee re ON e.id = re.employee_id 
  JOIN roles r ON re.role_id = r.id 
WHERE r.role_name LIKE '% Automation QA engineer';

SELECT r.role_name, e.employee_name, monthly_salary 
FROM employees e 
  JOIN employee_salary es ON es.employee_id = e.id 
  JOIN salary s ON es.salary_id = s.id 
  JOIN roles_employee re ON e.id = re.employee_id 
  JOIN roles r ON re.role_id = r.id 
WHERE r.role_name LIKE 'Junior %';

SELECT r.role_name, e.employee_name, monthly_salary 
FROM employees e 
  JOIN employee_salary es ON es.employee_id = e.id 
  JOIN salary s ON es.salary_id = s.id 
  JOIN roles_employee re ON e.id = re.employee_id 
  JOIN roles r ON re.role_id = r.id 
WHERE r.role_name LIKE 'Middle %';
  
SELECT r.role_name, e.employee_name, monthly_salary 
FROM employees e 
  JOIN employee_salary es ON es.employee_id = e.id 
  JOIN salary s ON es.salary_id = s.id 
  JOIN roles_employee re ON e.id = re.employee_id 
  JOIN roles r ON re.role_id = r.id 
WHERE r.role_name LIKE 'Senior %';
  
SELECT r.role_name, e.employee_name, monthly_salary 
FROM employees e 
  JOIN employee_salary es ON es.employee_id = e.id 
  JOIN salary s ON es.salary_id = s.id 
  JOIN roles_employee re ON e.id = re.employee_id 
  JOIN roles r ON re.role_id = r.id 
WHERE r.role_name LIKE '% Java developer';
  
SELECT r.role_name, e.employee_name, monthly_salary 
FROM employees e 
  JOIN employee_salary es ON es.employee_id = e.id 
  JOIN salary s ON es.salary_id = s.id 
  JOIN roles_employee re ON e.id = re.employee_id 
  JOIN roles r ON re.role_id = r.id 
WHERE r.role_name LIKE '% Python developer';
  
SELECT r.role_name, e.employee_name, monthly_salary 
FROM employees e 
  JOIN employee_salary es ON es.employee_id = e.id 
  JOIN salary s ON es.salary_id = s.id 
  JOIN roles_employee re ON e.id = re.employee_id 
  JOIN roles r ON re.role_id = r.id 
WHERE r.role_name LIKE 'Junior Python developer';

SELECT r.role_name, e.employee_name, monthly_salary 
FROM employees e 
  JOIN employee_salary es ON es.employee_id = e.id 
  JOIN salary s ON es.salary_id = s.id 
  JOIN roles_employee re ON e.id = re.employee_id 
  JOIN roles r ON re.role_id = r.id 
WHERE r.role_name LIKE 'Middle JavaScript developer';

SELECT r.role_name, e.employee_name, monthly_salary 
FROM employees e 
  JOIN employee_salary es ON es.employee_id = e.id 
  JOIN salary s ON es.salary_id = s.id 
  JOIN roles_employee re ON e.id = re.employee_id 
  JOIN roles r ON re.role_id = r.id 
WHERE r.role_name LIKE 'Senior JavaScript developer';
  
SELECT r.role_name, e.employee_name, monthly_salary 
FROM employees e 
  JOIN employee_salary es ON es.employee_id = e.id 
  JOIN salary s ON es.salary_id = s.id 
  JOIN roles_employee re ON e.id = re.employee_id 
  JOIN roles r ON re.role_id = r.id 
WHERE r.role_name LIKE 'Junior % QA engineer';
  
SELECT ROUND(avg(s.monthly_salary)) AS average_junior_salary 
FROM salary s 
  JOIN employee_salary es ON s.id = es.salary_id 
  JOIN roles_employee re ON es.employee_id = re.employee_id 
  JOIN roles r ON re.role_id = r.id  
WHERE r.role_name LIKE 'Junior %';
  
SELECT round(sum(s.monthly_salary), 2) AS summary_JS_salary
FROM salary s 
  JOIN employee_salary es ON s.id = es.salary_id 
  JOIN roles_employee re ON es.employee_id = re.employee_id 
  JOIN roles r ON re.role_id = r.id  
WHERE r.role_name LIKE '% JavaScript developer';
  
SELECT round(min(s.monthly_salary), 2) AS min_QA_salary
FROM salary s 
  JOIN employee_salary es ON s.id = es.salary_id 
  JOIN roles_employee re ON es.employee_id = re.employee_id 
  JOIN roles r ON re.role_id = r.id  
WHERE r.role_name LIKE '% QA engineer';
  
SELECT round(max(s.monthly_salary), 2) AS max_QA_salary
FROM salary s 
  JOIN employee_salary es ON s.id = es.salary_id 
  JOIN roles_employee re ON es.employee_id = re.employee_id 
  JOIN roles r ON re.role_id = r.id  
WHERE r.role_name LIKE '% QA engineer';
  
SELECT COUNT(role_name) AS total_QA 
FROM roles r 
  JOIN roles_employee re ON r.id = re.role_id 
WHERE r.role_name LIKE '% QA engineer';
 		
SELECT COUNT(role_name) AS total_Middle
FROM roles r 
  JOIN roles_employee re ON r.id = re.role_id 
WHERE r.role_name LIKE 'Middle %';

SELECT COUNT(role_name) AS summary_developer 
FROM roles r 
  JOIN roles_employee re ON r.id = re.role_id 
WHERE r.role_name LIKE '% developer';

SELECT sum(s.monthly_salary) AS summary_salary_developer 
FROM roles r 
  JOIN roles_employee re ON r.id = re.role_id 
  JOIN employee_salary es ON re.employee_id = es.employee_id 
  JOIN salary s ON es.salary_id = s.id 
WHERE r.role_name LIKE '% developer';

SELECT e.employee_name, r.role_name, s.monthly_salary 
FROM roles r 
  JOIN roles_employee re ON r.id = re.role_id 
  JOIN employees e ON re.employee_id = e.id 
  JOIN employee_salary es ON re.employee_id = es.employee_id 
  JOIN salary s ON es.salary_id = s.id 
ORDER BY s.monthly_salary;

SELECT e.employee_name, r.role_name, s.monthly_salary 
FROM roles r 
  JOIN roles_employee re ON r.id = re.role_id 
  JOIN employees e ON re.employee_id = e.id 
  JOIN employee_salary es ON re.employee_id = es.employee_id 
  JOIN salary s ON es.salary_id = s.id 
WHERE s.monthly_salary BETWEEN 1700 AND 2300
ORDER BY s.monthly_salary;

SELECT e.employee_name, r.role_name, s.monthly_salary 
FROM roles r 
  JOIN roles_employee re ON r.id = re.role_id 
  JOIN employees e ON re.employee_id = e.id 
  JOIN employee_salary es ON re.employee_id = es.employee_id 
  JOIN salary s ON es.salary_id = s.id 
WHERE s.monthly_salary < 2300
ORDER BY s.monthly_salary;
  
SELECT e.employee_name, r.role_name, s.monthly_salary 
FROM roles r 
  JOIN roles_employee re ON r.id = re.role_id 
  JOIN employees e ON re.employee_id = e.id 
  JOIN employee_salary es ON re.employee_id = es.employee_id 
  JOIN salary s ON es.salary_id = s.id 
WHERE s.monthly_salary IN (1100, 1500, 2000)
ORDER BY s.monthly_salary;
