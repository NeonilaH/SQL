/*1. Display information about all existing dishes in the format: [dish name]: [price] UAH
Set a temporary name for the resulting column - dish_information.*/

SELECT CONCAT (name, ': ', price, ' UAH') AS dish_information
FROM dish;

/*2. Display the number of new staff who were hired each year.
The result should contain the following columns:
the year from date_of_hiring: year
number of staff that were hired that year: number_of_staff*/

SELECT EXTRACT (YEAR FROM date_of_hiring) AS year, 
COUNT(id) AS number_of_staff
FROM staff
GROUP BY year;

/*3. Display the number of students who have a birthday in the current calendar month. 
Set a temporary name for the resulting column - number_of_pupils.*/

