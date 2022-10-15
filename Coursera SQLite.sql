// 1. Pull a list of customer ids with the customer’s full name, and address, along with combining their city and country together. Be sure to make a space in between these two and make it UPPER CASE. (e.g. LOS ANGELES USA)

SELECT CustomerId, FirstName, LastName, Address, 
  UPPER (City || ' '|| Country ||'') AS Location
FROM Customers
LIMIT 16

// 2. Create a new employee user id by combining the first 4 letters of the employee’s first name with the first 2 letters of the employee’s last name. Make the new field lower case and pull each individual step to show your work.

SELECT LOWER ((SUBSTR (FirstName, 0, 5)) || ''|| (SUBSTR (LastName, 0, 3) ||'')) AS New
FROM Employees

// 3. Show a list of employees who have worked for the company for 15 or more years using the current date function. Sort by lastname ascending.

SELECT FirstName || ' ' || LastName || ' ' || (DATE ('now') - HireDate) AS Employment
FROM Employees
ORDER BY 1

// 4. The COALESCE() function returns the first non-null value in a list.

SELECT * 
FROM user 
WHERE COALESCE(id
,name
,review_count
,yelping_since
,useful
,funny
,cool 
,fans 
,average_stars 
,compliment_hot 
,compliment_more 
,compliment_profile
,compliment_funny
,compliment_writer
,compliment_photos) IS NULL;
