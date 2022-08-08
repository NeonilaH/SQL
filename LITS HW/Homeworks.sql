 1. Необхідно реалізувати наступне:
— Скачати і встановити MySQL Workbench 
— Створити БД cinema
— Створити таблиці для цієї БД як на картинці cinemaBD
— В таблицях Ви самі визначаєте який тип даних буде у стовпців і з якими атрибутами
— Не забуваємо що кожна таблиця повинна містити стовпець ID
— Можете від себе додати ще таблиці і створити між ними зв’язок

CREATE database cinema;
CREATE TABLE viewer
(
id INT (5) AUTO_INCREMENT PRIMARY KEY,
firstName VARCHAR (15) NOT NULL,
secondName VARCHAR (20) NOT NULL
);
CREATE TABLE ticket
(
ticketID INT (5) AUTO_INCREMENT PRIMARY KEY,
movieSession DATE NOT NULL,
sessionTime TIME NOT NULL,
hallNumber INT (2) NOT NULL,
hallDescription VARCHAR (255) NOT NULL,
movieName VARCHAR (255) NOT NULL,
price float NOT NULL,
seat INT (2) NOT NULL,
rowNumber INT (2) NOT NULL,
FOREIGN KEY (ticketID) REFERENCES viewer (id)
);

2. Необхідно встановити БД Bank, а також БД World(якщо вона у Вас відсутня) і написати розв’язок до наступних завдань (всі вони до БД Bank):
— Вибрати всіх клієнтів в яких місто є Львів.
— Вибрати прізвище і імя клієнтів в яких вік є 21 рік.
— Вибрати клієнтів з вищою освітою.
— Вибрати клієнтів з середньою освітою і місто не Львів.
— Вибрати клієнтів в яких вік від 29 до 30 років і департамент не 4

SELECT * FROM bank.Client WHERE city = "lviv";
SELECT firstname, lastname FROM bank.Client WHERE age = "21";
SELECT * FROM bank.Client WHERE education = "high";
SELECT * FROM bank.Client WHERE education = "middle" AND NOT city = 'lviv';
SELECT * FROM bank.Client WHERE age >= "29" AND age <= "30" AND NOT Department_idDepartment = "4";

3.  Необхідно написати розв’язок до наступних завдань (всі вони до БД Bank):
— Вибрати усіх клієнтів, в якого id департаменту є 1 або 2 або 4.
— Вибрати усіх клієнтів, в якого вік не між 30 і 35 років.
— Вибрати клієнтів в яких прізвище закінчується на iv за допомогою like.
— Вибрати клієнтів в яких прізвище має iv за допомогою regexp.
— Вибрати усіх клієнтів в яких вік менше 25 і 2-га цифра в паспорті є 5.

SELECT * FROM bank.Client WHERE Department_idDepartment IN ("1", "2", "4");
SELECT * FROM bank.Client WHERE Age NOT BETWEEN 30 AND 35;
SELECT * FROM bank.Client WHERE LastName LIKE "%iv";
SELECT * FROM bank.Client WHERE LastName regexp "iv";
SELECT * FROM bank.Client WHERE Age < 25 AND Passport LIKE "___5%";

4. Необхідно написати розв’язок до наступних завдань (всі вони до БД Bank):
— Вивести всі дані про клієнтів банку посортувавши їх по віку від найменшого до найбільного.
— Вивести всі дані про клієнтів банку в яких місто є Київ та посортувавши їх по прізвищу за спаданням.
— Вивести всі дані про 3-х найстарших клієнтів банку.
— Вивести всі дані про наймолодшого клієнта банку.
— Вивести всі дані про клієнтів в яких вік є більшим чим середньостатистичний.

SELECT * FROM bank.Client ORDER BY age ASC;
SELECT * FROM bank.Client WHERE city = "Kyiv" ORDER BY lastname DESC;
SELECT * FROM bank.Client ORDER BY age DESC LIMIT 3;
SELECT * FROM bank.Client WHERE age = (SELECT MIN(age) FROM bank.client);
SELECT * FROM bank.Client WHERE age > (SELECT AVG(age) FROM bank.Client);

5. Необхідно написати розв’язок до наступних завдань (всі вони до БД Bank):
— Вивести імена клієнтів та їхні паспортні данні, погрупувавши їх за іменами.
— Вивести дані про клієнтів, які мають кредит більше ніж на 5000 тисяч гривень.
— Порахувати кількість клієнтів усіх відділень та лише львівських відділень.
— Знайти кредити, які мають найбільшу суму для кожного клієнта окремо.
— Визначити найбільший та найменший кредити.

SELECT FirstName, passport FROM bank.Client
ORDER BY FirstName;

SELECT * FROM bank.Client
INNER JOIN bank.Application
ON Department_idDepartment = Client_idClient
WHERE sum > 5000;

SELECT COUNT(LastName) 
FROM bank.Client
UNION all
SELECT COUNT(LastName) 
FROM bank.Client
INNER JOIN bank.Department
ON idDepartment = Department_idDepartment 
WHERE DepartmentCity = "Lviv";

SELECT sum, Client_idClient
FROM bank.Application
LEFT JOIN bank.Client
ON Department_idDepartment = Client_idClient
AND sum = (SELECT MAX(sum) 
           FROM bank.Application
           WHERE Client_idClient);

SELECT MIN(sum), MAX(sum)
FROM bank.Application;
