/* 1. Display information about all existing dishes in the format: [dish name]: [price] UAH
Set a temporary name for the resulting column - dish_information. */

SELECT CONCAT(name, ': ', price, ' UAH') AS dish_information
FROM dish;

/* 2. Display the number of new staff who were hired each year.
The result should contain the following columns:
the year from date_of_hiring: year
number of staff that were hired that year: number_of_staff */

SELECT EXTRACT (YEAR FROM date_of_hiring) AS year, 
COUNT(id) AS number_of_staff
FROM staff
GROUP BY year;

/* 3. Display the number of students who have a birthday in the current calendar month. 
Set a temporary name for the resulting column - number_of_pupils. */

SELECT COUNT(id) AS number_of_pupils
FROM pupil
WHERE EXTRACT(MONTH FROM CURRENT_DATE) = EXTRACT(MONTH FROM birth_date);

/* 4.The tables category and product are given.
Display information about each of the products of the category 'Beverages' in the form: [product name] - [amount] units.
Set a temporary name for the resulting column - product_information. */

SELECT CONCAT(p.name, ' - ', amount, ' units') AS product_information
FROM category c
    JOIN product p ON c.id = p.category_id
WHERE c.name = 'Beverages';

/* 5. Display information (first_name and last_name) about the staff who are not working anymore.
Present the date of dismissal in three different columns: day, month, year */

SELECT first_name, last_name, EXTRACT(DAY FROM date_of_dismissal) AS day, EXTRACT(MONTH FROM date_of_dismissal) AS month, EXTRACT(YEAR FROM date_of_dismissal) AS year
FROM staff
WHERE date_of_dismissal IS NOT NULL;

/* 6. The tables scoreboard and pupil are given.
Display the average mark of each subject for the student with the id 3.
Present the result in column named pupil_mark as follows: [first_name] [last_name]: [subject] - [average mark]. */

SELECT CONCAT(first_name, ' ', last_name, ': ', s.subject, ' - ', AVG(s.mark)) AS pupil_mark
FROM scoreboard s
    JOIN pupil p ON p.id = s.pupil_id
WHERE p.id = 3
GROUP BY s.subject;

/* 7. Display information about the number of employees who were hired each month.
Show the result only if the number of employees is 3 or more.
The result should contain the following columns:
month from hiring_date: month
the number of employees that were hired that month: number_of_employees. */

SELECT EXTRACT(MONTH FROM hiring_date) AS month, COUNT(id) AS number_of_employees
FROM employee
GROUP BY month
HAVING COUNT(id) >= 3;
