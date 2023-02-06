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

-- Let's create a name column that has the first letter of the firstname, followed by a dot and the lastname in all uppercase:
SELECT CONCAT(
   SUBSTRING(firstname, 1, 1), 
   '. ', 
   UPPER(lastname)) AS name
FROM Customers

-- We want to set the __category__ columns value to __'Senior'__, in case the age value is greater than 65, __'Adult'__ in case it's in the range of 25 to 64, and __'Youth'__, if it's under 25. This is done using the __CASE__ statement.
SELECT firstname, lastname,
CASE
    WHEN age >= 65 THEN 'Senior' 
END AS category
FROM Customers
