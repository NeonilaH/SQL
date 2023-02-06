ALTER TABLE cities
ADD AttractivePlace VARCHAR(128);
UPDATE cities
SET AttractivePlace = 'Belem Tower' WHERE name = 'Lisbon';
UPDATE cities
SET  AttractivePlace = 'Plaza Mayor' WHERE name = 'Madrid';
UPDATE cities
SET AttractivePlace = 'Eiffel Tower' WHERE name = 'Paris';
SELECT * FROM cities;

RENAME TABLE people
TO humans;

CREATE VIEW CList AS
SELECT FirstName, Salary
FROM  Employees;
SELECT * FROM List;

CREATE OR REPLACE VIEW List AS
SELECT FirstName, LastName, Salary
FROM  Employees;

DROP VIEW List;

ALTER TABLE people
DROP COLUMN age;

DROP TABLE students; 

-- The REPLACE function replaces all occurrences of the given string with another one. For example, let's replace New York with NY in the city column:
SELECT firstname, lastname, 
REPLACE(city, 'New York', 'NY') 
FROM Customers
