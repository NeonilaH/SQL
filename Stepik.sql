-- 1.1

CREATE TABLE book(
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8, 2),
    amount INT);

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
    FROM book )
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
    HAVING COUNT(amount) = 1);

SELECT author, title, price
FROM book
WHERE price < ANY (
        SELECT MIN(price) 
        FROM book 
        GROUP BY author);

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
        FROM book);

UPDATE book
SET price = price * 0.9
WHERE amount BETWEEN 5 and 10;

UPDATE book
SET buy = IF(buy > amount, amount, buy),
    price = IF(buy = 0, price * 0.9, price);
    
UPDATE book, supply
SET book.amount = book.amount + supply.amount,
    book.price = (book.price + supply.price)/2
WHERE book.title = supply.title AND book.author = supply.author;

DELETE FROM supply
WHERE author IN(
    SELECT author
    FROM book
    GROUP BY author
    HAVING SUM(amount) > 10);

CREATE TABLE ordering AS 
SELECT author, title,
    (SELECT ROUND(AVG(amount)) FROM book) AS amount
    FROM book
    WHERE amount < (SELECT AVG(amount) FROM book);

-- 1.6
    
SELECT name, city, per_diem, date_first, date_last
FROM trip
WHERE name LIKE '%а %'
ORDER BY date_last DESC;

SELECT DISTINCT name
FROM trip
WHERE city = "Москва"
ORDER BY name ASC;

SELECT city, COUNT(city) AS Количество
FROM trip
GROUP BY city
ORDER BY city ASC;

SELECT city, COUNT(city) AS Количество
FROM trip
GROUP BY city
LIMIT 2;

SELECT name, city, DATEDIFF(date_last, date_first) + 1 AS Длительность
FROM trip
WHERE city != "Москва" AND city != "Санкт-Петербург"
ORDER BY 3 DESC, 2 DESC;

SELECT name, city, date_first, date_last
FROM trip
WHERE DATEDIFF(date_last, date_first) = 
    (SELECT MIN(DATEDIFF(date_last, date_first)) FROM trip);

SELECT name, city, date_first, date_last
FROM trip
WHERE MONTH(date_first) = MONTH(date_last)
ORDER BY 2, 1;

SELECT MONTHNAME(date_first) AS Месяц, 
    COUNT(MONTH(date_first)) AS Количество
FROM trip
GROUP BY 1
ORDER BY 2 DESC, 1;

SELECT name, city, date_first, 
    (DATEDIFF(date_last, date_first) + 1) * per_diem AS Сумма
FROM trip
WHERE MONTHNAME(date_first) IN ("February", "March")
ORDER BY 1, 4 DESC;

SELECT name, SUM((DATEDIFF(date_last, date_first) + 1) * per_diem) AS Сумма
FROM trip
GROUP BY name
HAVING COUNT(name) > 3
ORDER BY 2 DESC;

-- 1.7

CREATE TABLE fine (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    number_plate VARCHAR(6),
    violation VARCHAR(50),
    sum_fine FLOAT(8,2),
    date_violation DATE,
    date_payment DATE);

INSERT INTO fine (name, number_plate, violation, sum_fine, date_violation, date_payment)
    VALUES ("Баранов П.Е.", "Р523ВТ", "Превышение скорости(от 40 до 60)", NULL, "2020-02-14", NULL),
          ("Абрамова К.А.", "О111АВ", "Проезд на запрещающий сигнал", NULL, "2020-02-23", NULL),
          ("Яковлев Г.Р.", "Т330ТТ", "Проезд на запрещающий сигнал", NULL, "2020-03-03", NULL);

UPDATE fine f, traffic_violation AS tv
SET f.sum_fine=tv.sum_fine
WHERE f.sum_fine IS NULL AND f.violation=tv.violation;

SELECT name, number_plate, violation
FROM fine
GROUP BY name, number_plate, violation
HAVING COUNT(name) AND COUNT(number_plate) AND COUNT(violation) >=2 
        --HAVING COUNT(*)>=2 - alternatively
ORDER BY 1, 2, 3;

UPDATE fine f, (SELECT name, number_plate, violation
        FROM fine
        GROUP BY name, number_plate, violation
        HAVING COUNT(*)>=2) q
SET f.sum_fine = f.sum_fine * 2
WHERE f.date_payment IS NULL AND 
    f.name = q.name AND 
    f.number_plate = q.number_plate AND 
    f.violation = q.violation;

UPDATE fine f, payment p
SET f.date_payment = p.date_payment,
    f.sum_fine = IF (DATEDIFF(p.date_payment, p.date_violation) <= 20, f.sum_fine/2, f.sum_fine)
WHERE f.date_payment IS NULL AND 
        f.name = p.name AND
        f.number_plate = p.number_plate AND
        f.violation = p.violation;

CREATE TABLE back_payment AS 
SELECT name, number_plate, violation, sum_fine, date_violation 
FROM fine
WHERE date_payment IS NULL;

DELETE FROM fine
WHERE date_violation < "2020-02-01";


-- ________________________________________________________________________________________________

--2.1

CREATE TABLE author(
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author	VARCHAR(50));

INSERT INTO author (name_author)
VALUES ("Булгаков М.А."),
        ("Достоевский Ф.М."),
        ("Есенин С.А."),
        ("Пастернак Б.Л.");

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50), 
    author_id INT NOT NULL, 
    genre_id INT,
    price DECIMAL(8,2), 
    amount INT, 
    FOREIGN KEY (author_id) REFERENCES author (author_id),
    FOREIGN KEY (genre_id) REFERENCES genre (genre_id));

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50), 
    author_id INT NOT NULL, 
    genre_id INT,
    price DECIMAL(8,2), 
    amount INT, 
    FOREIGN KEY (author_id) REFERENCES author (author_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genre (genre_id) ON DELETE SET NULL);

INSERT INTO book (title, author_id, genre_id, price, amount)
VALUES ('Стихотворения и поэмы',3, 2, 650.00, 15),
        ('Черный человек', 3, 2, 570.20, 6),
        ('Лирика', 4, 2, 518.99, 2)

-- 2.2

SELECT title, name_genre, price
FROM book 
    INNER JOIN genre
    ON book.genre_id = genre.genre_id
WHERE amount > 8
ORDER BY price DESC;

SELECT name_genre
FROM genre LEFT JOIN book
    ON genre.genre_id = book.genre_id
WHERE book.genre_id IS NULL;
                --SELECT name_genre
                --FROM book RIGHT JOIN genre
                --   ON genre.genre_id = book.genre_id
                --WHERE book.genre_id IS NULL;

SELECT city.name_city, author.name_author, 
    (DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 365) DAY)) as Дата
FROM city CROSS JOIN author     --FROM city, author --alternatively
ORDER BY 1, 3 DESC;

SELECT name_genre, title, name_author
FROM book 
INNER JOIN author ON author.author_id = book.author_id
INNER JOIN genre ON genre.genre_id = book.genre_id
WHERE genre.name_genre LIKE "роман"
ORDER BY 2;

SELECT name_author, SUM(amount) AS Количество
FROM book
    RIGHT JOIN author ON book.author_id = author.author_id
GROUP BY name_author
HAVING SUM(amount) < 10 OR SUM(amount) IS NULL
ORDER BY 2;

SELECT name_author
FROM book
    INNER JOIN  author ON author.author_id  = book.author_id
GROUP BY name_author 
HAVING COUNT(DISTINCT book.genre_id) = 1; 

SELECT title, name_author, name_genre, price, amount
FROM book JOIN author ON book.author_id = author.author_id
          JOIN genre ON book.genre_id = genre.genre_id
WHERE book.genre_id IN (
          SELECT genre_id
          FROM book 
          GROUP BY genre_id
          HAVING SUM(amount) = (
              SELECT SUM(amount)
              FROM book
              GROUP BY genre_id
              LIMIT 1))
ORDER BY title;
      
SELECT b.title AS Название, name_author AS Автор, b.amount + s.amount AS Количество
FROM book b
    INNER JOIN author a USING(author_id)
    INNER JOIN supply s ON a.name_author = s.author
    WHERE b.title = s.title AND b.price = s.price;

-- 2.3

UPDATE book b
    INNER JOIN author a ON b.author_id = a.author_id
    INNER JOIN supply s ON s.title = b.title AND a.name_author = s.author 
SET 
    b.price = (b.price * b.amount + s.price * s.amount) / (b.amount + s.amount),
    b.amount = b.amount + s.amount,
    s.amount = 0
WHERE b.price != s.price;

INSERT INTO author (name_author)
SELECT supply.author
FROM author 
    RIGHT JOIN supply on author.name_author = supply.author
WHERE name_author IS Null;
SELECT * FROM author;

INSERT INTO book (title, author_id, price, amount)
SELECT title, author_id, price, amount
FROM author 
    INNER JOIN supply ON author.name_author = supply.author
WHERE amount <> 0;
SELECT * FROM book;

UPDATE book
SET genre_id = (
       SELECT genre_id 
       FROM genre 
       WHERE name_genre = "Поэзия")
WHERE title = "Стихотворения и поэмы";
UPDATE book
SET genre_id = (
       SELECT genre_id 
       FROM genre 
       WHERE name_genre = "Приключения")
WHERE title = "Остров сокровищ";
SELECT * FROM book;

DELETE FROM author
WHERE author_id IN( 
            SELECT author_id
            FROM book
            GROUP BY author_id
            HAVING SUM(amount) < 20);

DELETE FROM genre
WHERE genre_id IN (
    SELECT genre_id
    FROM book
    GROUP BY genre_id
    HAVING COUNT(book_id) < 4);

DELETE FROM author
USING author
     INNER JOIN book ON author.author_id = book.author_id
     INNER JOIN genre ON genre.genre_id = book.genre_id     
WHERE name_genre = 'Поэзия';

-- 2.4

SELECT buy_book.buy_id, book.title, book.price, buy_book.amount
FROM buy_book
    INNER JOIN book ON buy_book.book_id = book.book_id
    INNER JOIN buy ON buy_book.buy_id = buy.buy_id
    INNER JOIN client ON client.client_id = buy.client_id
WHERE client.name_client = "Баранов Павел"
ORDER BY 1, 2;

SELECT author.name_author, book.title, COUNT(buy_book.amount) AS Количество
FROM book
    INNER JOIN author ON author.author_id = book.author_id
    LEFT JOIN buy_book ON buy_book.book_id = book.book_id
GROUP BY book.title, name_author
ORDER BY name_author, title;

SELECT name_city, COUNT(buy.buy_id) AS Количество
FROM city
    INNER JOIN client USING (city_id)
    INNER JOIN buy USING (client_id) 
GROUP BY name_city
ORDER BY 2 DESC, 1;

SELECT buy_step.buy_id, buy_step.date_step_end
FROM buy_step
WHERE date_step_end IS NOT NULL and step_id IN (
    SELECT step_id
    FROM step
    WHERE name_step = "Оплата");

SELECT buy.buy_id, client.name_client, SUM(buy_book.amount * book.price) AS Стоимость
FROM buy
    INNER JOIN client USING (client_id)
    INNER JOIN buy_book USING (buy_id)
    INNER JOIN book USING (book_id)
GROUP BY buy.buy_id
ORDER BY 1;

SELECT buy_id, name_step
FROM step 
    INNER JOIN buy_step USING (step_id)
WHERE date_step_beg IS NOT NULL AND date_step_end IS NULL
ORDER BY 1;

SELECT buy_id, DATEDIFF(date_step_end, date_step_beg) AS Количество_дней, 
        IF (DATEDIFF(date_step_end, date_step_beg) > city.days_delivery, 
        DATEDIFF(date_step_end, date_step_beg) - city.days_delivery, 0) AS Опоздание
FROM buy_step
    INNER JOIN step USING (step_id)
    INNER JOIN buy USING (buy_id)
    INNER JOIN client USING (client_id)
    INNER JOIN city USING (city_id)
WHERE step.name_step = "Транспортировка" and buy_step.date_step_end IS NOT NULL;

SELECT DISTINCT name_client
FROM client
    INNER JOIN buy USING (client_id)
    INNER JOIN buy_book USING (buy_id)
    INNER JOIN book USING (book_id)
    INNER JOIN author USING (author_id)
WHERE name_author LIKE "Достоевск%"
ORDER BY 1;

SELECT name_genre, SUM(buy_book.amount) AS Количество
FROM genre
    INNER JOIN book USING (genre_id)
    INNER JOIN buy_book USING (book_id)
WHERE book.genre_id IN (
          SELECT genre_id
          FROM book 
          GROUP BY genre_id
          HAVING SUM(amount) = (
              SELECT SUM(amount)
              FROM book
              GROUP BY genre_id
              LIMIT 1))
GROUP BY genre_id;

SELECT YEAR(date_step_end) AS Год, MONTHNAME (date_step_end) AS Месяц, SUM(book.price * buy_book.amount) AS Сумма
FROM book 
    INNER JOIN buy_book ON book.book_id = buy_book.book_id
    INNER JOIN buy_step ON buy_book.buy_id = buy_step.buy_id
    INNER JOIN step ON buy_step.step_id = step.step_id
WHERE date_step_end IS NOT NULL AND name_step = "Оплата"
GROUP BY 2, 1
UNION
SELECT YEAR(date_payment) AS Год, MONTHNAME (date_payment) AS Месяц, SUM(buy_archive.price * buy_archive.amount) AS Сумма
FROM buy_archive
WHERE date_payment IS NOT NULL
GROUP BY 2, 1
ORDER BY 2, 1;

SELECT title, SUM(Quantity) AS Количество, SUM(Total) AS Сумма
FROM (
    SELECT b.title, SUM(bb.amount) AS Quantity, SUM(b.price * bb.amount) AS Total
    FROM book b
        INNER JOIN buy_book bb USING (book_id)
        INNER JOIN buy_step bs USING (buy_id)
        INNER JOIN step s USING (step_id)
    WHERE s.name_step = "Оплата" AND date_step_end IS NOT NULL
    GROUP BY 1
    UNION ALL
    SELECT b.title, SUM(ba.amount) AS Quantity, SUM(ba.price * ba.amount) AS Total
    FROM book b 
        INNER JOIN buy_archive ba USING (book_id)
    GROUP BY 1) temp
GROUP BY 1
ORDER BY 2 DESC;

-- 2.5

INSERT INTO client (name_client, city_id, email)
SELECT "Попов Илья", city_id, "popov@test"
FROM city
WHERE name_city = "Москва";

INSERT INTO buy (buy_description, client_id)
SELECT "Связаться со мной по вопросу доставки", client_id
FROM client
WHERE name_client = "Попов Илья";

INSERT INTO buy_book (buy_id, book_id, amount)
VALUES 
(5, (SELECT book_id 
     FROM book 
     WHERE title = "Лирика" AND author_id IN (
         SELECT author_id 
         FROM author 
         WHERE name_author LIKE "Пастернак%")), 2),
         
(5, (SELECT book_id 
     FROM book 
     WHERE title = "Белая гвардия" AND author_id IN (
         SELECT author_id 
         FROM author 
         WHERE name_author LIKE "Булгаков%")), 1);

UPDATE book b, buy_book bb
SET b.amount = b.amount - bb.amount 
WHERE bb.buy_id = 5 AND b.book_id = bb.book_id;

CREATE TABLE buy_pay AS
SELECT title, name_author, b.price, bb.amount,
        b.price * bb.amount AS Стоимость
        FROM book b
        INNER JOIN author USING (author_id)
        INNER JOIN buy_book bb USING (book_id)
WHERE bb.buy_id = 5
ORDER BY 1;
SELECT * FROM buy_pay;

INSERT INTO buy_step (buy_id, step_id, date_step_beg, date_step_end)
SELECT buy_id, step_id, NULL, NULL
FROM step, buy
WHERE buy_id = 5;

UPDATE buy_step
SET date_step_beg = "2020-04-12"
WHERE buy_id = 5 and step_id = 1;

UPDATE buy_step
SET date_step_end = "2020-04-13"
WHERE buy_id = 5 AND step_id = (
    SELECT step_id 
    FROM step
    WHERE name_step = "Оплата"), 
UPDATE buy_step
SET date_step_beg = "2020-04-13"
WHERE buy_id = 5 AND step_id = (
    SELECT step_id + 1 
    FROM step
    WHERE name_step = "Оплата");

-- ________________________________________________________________________________________________

-- 3.1

SELECT name_student, date_attempt, result
FROM student
    JOIN attempt USING (student_id) 
    JOIN subject USING (subject_id)
WHERE name_subject = "Основы баз данных"
ORDER BY 3 DESC;

SELECT name_subject, COUNT(attempt_id) AS Количество, ROUND(AVG(result), 2) AS Среднее
FROM attempt
        RIGHT JOIN subject USING (subject_id)
GROUP BY 1
ORDER BY 3 DESC;

SELECT name_student, result
FROM student
    JOIN attempt USING (student_id)
WHERE result = (
        SELECT MAX(result)
        FROM attempt)
ORDER BY 1;

SELECT name_student, name_subject, DATEDIFF(MAX(date_attempt), MIN(date_attempt)) AS Интервал
FROM student
    JOIN attempt USING (student_id)
    JOIN subject USING (subject_id)
GROUP BY 1, 2
HAVING COUNT(date_attempt) > 1
ORDER BY 3;

SELECT name_subject, IFNULL(COUNT(DISTINCT student_id), 0) AS Количество
FROM subject 
    LEFT JOIN attempt USING (subject_id)
GROUP BY 1
ORDER BY 2 DESC;
                    /*SELECT name_subject, IF(COUNT(DISTINCT student_id) > 0, COUNT(DISTINCT student_id), 0) AS Количество
                    FROM subject 
                        LEFT JOIN attempt USING (subject_id)
                    GROUP BY 1
                    ORDER BY 2 DESC;*/

SELECT question_id, name_question
FROM subject
    JOIN question USING (subject_id)
    WHERE name_subject = "Основы баз данных"
ORDER BY RAND()
LIMIT 3;

SELECT name_question, name_answer, IF(is_correct = 1, "Верно", "Неверно") AS Результат
FROM question 
    JOIN testing USING (question_id)
    JOIN answer USING (answer_id)
WHERE attempt_id = 7;

SELECT name_student, name_subject, date_attempt, ROUND((SUM(is_correct) / 3 * 100), 2) AS Результат
FROM student
    JOIN attempt USING(student_id)
    JOIN subject USING(subject_id)
    JOIN testing USING(attempt_id)
    JOIN answer USING(answer_id)
GROUP BY 1, 2, 3
ORDER BY 1, 3 DESC;

SELECT name_subject, 
    CONCAT(LEFT(name_question, 30), '...') AS Вопрос, 
    COUNT(t.answer_id) AS Всего_ответов,
    ROUND(SUM(is_correct) / COUNT(t.answer_id) * 100, 2) AS Успешность
FROM subject
    JOIN question USING (subject_id)
    JOIN testing t USING(question_id)
    LEFT JOIN answer a USING (answer_id)
GROUP BY 1, 2
ORDER BY 1, 4 DESC, 2;

-- 3.2

INSERT INTO attempt (student_id, subject_id, date_attempt, result)
SELECT st.student_id, sb.subject_id, NOW(), NULL
FROM student st
    JOIN attempt a USING (student_id)
    LEFT JOIN subject sb USING (subject_id)
WHERE name_subject = "Основы баз данных" AND name_student = "Баранов Павел";

INSERT INTO testing (attempt_id, question_id, answer_id)
SELECT attempt_id, question_id, NULL
FROM attempt
    JOIN question USING (subject_id)
WHERE attempt_id = 
        (SELECT MAX(attempt_id) FROM attempt)
ORDER BY RAND()
LIMIT 3;

UPDATE attempt
SET result = (SELECT ROUND((SUM(is_correct) / 3 * 100), 0) 
                     FROM answer
                     JOIN testing USING (answer_id)
                     WHERE attempt_id = 8)
WHERE attempt_id = 8;

DELETE FROM attempt
WHERE date_attempt < "2020-05-01";

-- 3.3 

SELECT name_enrollee
FROM enrollee
    JOIN program_enrollee USING(enrollee_id)
    JOIN program USING(program_id)
WHERE name_program = "Мехатроника и робототехника"
ORDER BY 1;

SELECT name_program
FROM program
    JOIN program_subject USING (program_id)
    JOIN subject USING (subject_id)
WHERE name_subject = "Информатика"
ORDER BY 1 DESC;

SELECT name_subject,
    ROUND (COUNT(enrollee_id), 1) AS Количество,
    ROUND (MAX(result), 1) AS Максимум,
    ROUND (MIN(result), 1) AS Минимум,
    ROUND (AVG(result), 1) AS Среднее
FROM subject s
    JOIN enrollee_subject es ON s.subject_id = es.subject_id
GROUP BY 1
ORDER BY 1;

SELECT name_program
FROM program
    JOIN program_subject USING (program_id)
GROUP BY name_program
HAVING MIN(min_result) >= 40
ORDER BY 1;

SELECT name_program, plan
FROM program
WHERE plan = (
    SELECT MAX(plan)
    FROM program);

SELECT name_enrollee, IFNULL(SUM(bonus), 0) AS Бонус
FROM enrollee e
    LEFT JOIN enrollee_achievement ea ON e.enrollee_id = ea.enrollee_id
    LEFT JOIN achievement a ON a.achievement_id = ea.achievement_id
GROUP BY 1
ORDER BY 1;

SELECT name_department, 
    name_program, 
    plan, 
    COUNT(enrollee_id) AS Количество, 
    ROUND (COUNT(enrollee_id)/plan, 2) AS Конкурс
FROM department
    JOIN program USING (department_id)
    JOIN program_enrollee USING (program_id)
GROUP BY program_id
ORDER BY plan;

SELECT name_program
FROM program
    JOIN program_subject USING (program_id)
    JOIN subject USING (subject_id)
WHERE name_subject IN ("Информатика", "Математика")
GROUP BY name_program
HAVING COUNT(name_subject) = 2
ORDER BY name_program;

SELECT name_program, name_enrollee, SUM(result) AS itog
FROM enrollee
    JOIN program_enrollee USING (enrollee_id)
    JOIN program USING (program_id)
    JOIN program_subject USING (program_id)
    JOIN enrollee_subject USING (enrollee_id, subject_id)
GROUP BY 1, 2
ORDER BY 1, 3 DESC;
