-- 1.1

CREATE TABLE book(
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8, 2),
    amount INT
);

INSERT INTO book (book_id, title, author, price, amount) 
VALUES (1, "Мастер и Маргарита", "Булгаков М.А.", 670.99, 3);

INSERT INTO book (book_id, title, author, price, amount) 
VALUES (2, "Белая гвардия", "Булгаков М.А.", 540.50, 5), 
        (3, "Идиот", "Достоевский Ф.М.", 460.00, 10), 
        (4, "Братья Карамазовы", "Достоевский Ф.М.", 799.01, 2);


-- 1.2

SELECT * FROM book;

SELECT author, title, price FROM book

SELECT title AS Название, author AS Автор
FROM book;

SELECT title, amount, 1.65 * amount AS pack
FROM book;

SELECT title, author, amount, ROUND ((price * 0.7), 2) AS new_price
FROM book

SELECT author, title, 
    ROUND(IF(author = "Булгаков М.А.", price * 1.1, IF(author = "Есенин С.А.", price * 1.05, price)), 2) AS new_price
FROM book;

SELECT author, title, price
FROM book
WHERE amount < 10;

SELECT title, author, price, amount FROM book
WHERE (price < 500 OR price > 600) AND price * amount >= 5000

SELECT title, author
FROM book
WHERE price BETWEEN 540.50 AND 800 AND amount IN (2, 3, 5, 7);

SELECT author, title FROM book
WHERE amount BETWEEN 2 AND 14
ORDER BY author DESC, title ASC;

SELECT author, title FROM book
WHERE amount BETWEEN 2 AND 14
ORDER BY 1 DESC, 2 ASC;

SELECT title, author FROM book
WHERE title LIKE "_% %" AND author LIKE "%С.%"
ORDER BY 1 ASC;

-- 1.3

SELECT DISTINCT amount
FROM book

SELECT author AS Автор, COUNT(amount) AS Различных_книг, SUM(amount) AS Количество_экземпляров
FROM book
GROUP BY author;

SELECT author, MIN(price) AS Минимальная_цена, MAX(price) AS Максимальная_цена, AVG(price) AS Средняя_цена
FROM book
GROUP BY author;

SELECT author, 
    SUM(price * amount) AS Стоимость, 
    ROUND(SUM(price * amount / 118 * 18),2) AS НДС, 
    ROUND(SUM(price * amount - price * amount / 118 * 18),2) AS Стоимость_без_НДС
FROM book
GROUP BY author;

SELECT MIN(price) AS Минимальная_цена, MAX(price) AS Максимальная_цена, ROUND(AVG(price),2) AS Средняя_цена
FROM book;

SELECT ROUND(AVG(price),2) AS Средняя_цена, 
    SUM(price*amount) AS Стоимость
FROM book
WHERE amount BETWEEN 5 and 14;

SELECT author,
SUM(price * amount) AS Стоимость
FROM book
WHERE title != "Идиот" AND title <> "Белая гвардия"
GROUP BY author
HAVING SUM(price * amount) > 5000
ORDER BY Стоимость DESC;

-- 1.4

SELECT author, title, price
FROM book
WHERE price <= (
    SELECT AVG(price)
    FROM book
)
ORDER by price DESC;

SELECT author, title, price
FROM book
WHERE ABS(price -150) <= (SELECT MIN(price) FROM book)
ORDER BY price ASC;

SELECT author, title, amount
FROM book
WHERE amount IN (
    SELECT amount
    FROM book
    GROUP BY amount
    HAVING COUNT(amount) = 1
    );

SELECT author, title, price
FROM book
WHERE price < ANY (
        SELECT MIN(price) 
        FROM book 
        GROUP BY author 
      );

SELECT title, author, amount,
         ABS(amount - (SELECT MAX(amount) FROM book)) AS Заказ
FROM book
WHERE ABS(amount - (SELECT MAX(amount) FROM book)) !=0;

-- 1.5

CREATE TABLE supply (
    supply_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8, 2),
    amount INT);

INSERT INTO supply (title, author, price, amount)
VALUES 
    ("Лирика", "Пастернак Б.Л.", 518.99, 2),
    ("Черный человек", "Есенин С.А.", 570.20, 6),
    ("Белая гвардия", "Булгаков М.А.", 540.50, 7),
    ("Идиот", "Достоевский Ф.М.", 360.80, 3);

INSERT INTO book (title, author, price, amount) 
    SELECT title, author, price, amount 
    FROM supply
    WHERE author NOT IN ("Булгаков М.А.", "Достоевский Ф.М.");

INSERT INTO book (title, author, price, amount) 
SELECT title, author, price, amount 
FROM supply
WHERE author NOT IN (
        SELECT author 
        FROM book
      );

UPDATE book
SET price = price * 0.9
WHERE amount BETWEEN 5 and 10;

UPDATE book
SET buy = IF(buy > amount, amount, buy),
    price = IF(buy = 0, price * 0.9, price);
