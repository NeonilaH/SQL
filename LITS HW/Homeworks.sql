 1. Необхідно реалізувати наступне:
— Скачати і встановити MySQL Workbench 
— Створити БД cinema
— Створити таблиці для цієї БД як на картинці cinemaBD
— В таблицях Ви самі визначаєте який тип даних буде у стовпців і з якими атрибутами
— Не забуваємо що кожна таблиця повинна містити стовпець ID
— Можете від себе додати ще таблиці і створити між ними зв’язок

create database cinema;
create table viewer
(
id int (5) auto_increment primary key,
firstName varchar (15) not null,
secondName varchar (20) not null
);
create table ticket
(
ticketID int (5) auto_increment primary key,
movieSession date not null,
sessionTime time not null,
hallNumber int (2) not null,
hallDescription varchar (255) null,
movieName varchar (255) not null,
price float not null,
seat int (2) not null,
rowNumber int (2) not null,
foreign key (ticketID) references viewer (id)
);

2. Необхідно встановити БД Bank, а також БД World(якщо вона у Вас відсутня) і написати розв’язок до наступних завдань (всі вони до БД Bank):
— Вибрати всіх клієнтів в яких місто є Львів.
— Вибрати прізвище і ім'я клієнтів в яких вік є 21 рік.
— Вибрати клієнтів з вищою освітою.
— Вибрати клієнтів з середньою освітою і місто не Львів.
— Вибрати клієнтів в яких вік від 29 до 30 років і департамент не 4

SELECT * FROM bank.Client where city = "lviv";
SELECT firstname, lastname FROM bank.Client where age = "21";
SELECT * FROM bank.Client where education = "high";
SELECT * FROM bank.Client where education = "middle" and not city = 'lviv';
SELECT * FROM bank.Client where age >= "29" and age <= "30" and not Department_idDepartment = "4";

3.  Необхідно написати розв’язок до наступних завдань (всі вони до БД Bank):
— Вибрати усіх клієнтів, в якого id департаменту є 1 або 2 або 4.
— Вибрати усіх клієнтів, в якого вік не між 30 і 35 років.
— Вибрати клієнтів в яких прізвище закінчується на iv за допомогою like.
— Вибрати клієнтів в яких прізвище має iv за допомогою regexp.
— Вибрати усіх клієнтів в яких вік менше 25 і 2-га цифра в паспорті є 5.

SELECT * FROM bank.Client where Department_idDepartment in ("1", "2", "4");
SELECT * FROM bank.Client where Age not between 30 and 35;
SELECT * FROM bank.Client where LastName like "%iv";
SELECT * FROM bank.Client where LastName regexp "iv";
SELECT * FROM bank.Client where Age < 25 and Passport like "___5%";

4. Необхідно написати розв’язок до наступних завдань (всі вони до БД Bank):
— Вивести всі дані про клієнтів банку посортувавши їх по віку від найменшого до найбільного.
— Вивести всі дані про клієнтів банку в яких місто є Київ та посортувавши їх по прізвищу за спаданням.
— Вивести всі дані про 3-х найстарших клієнтів банку.
— Вивести всі дані про наймолодшого клієнта банку.
— Вивести всі дані про клієнтів в яких вік є більшим чим середньостатистичний.

SELECT * FROM bank.Client order by age asc;
SELECT * FROM bank.Client where city = "Kyiv" order by lastname desc;
SELECT * FROM bank.Client order by age desc limit 3;
SELECT * FROM bank.Client where age = (select min(age) from bank.client);
SELECT * FROM bank.Client where age > (select avg(age) from bank.Client);

5. Необхідно написати розв’язок до наступних завдань (всі вони до БД Bank):
— Вивести імена клієнтів та їхні паспортні данні, погрупувавши їх за іменами.
— Вивести дані про клієнтів, які мають кредит більше ніж на 5000 тисяч гривень.
— Порахувати кількість клієнтів усіх відділень та лише львівських відділень.
— Знайти кредити, які мають найбільшу суму для кожного клієнта окремо.
— Визначити найбільший та найменший кредити.

SELECT FirstName, passport FROM bank.Client
order by FirstName;

select * FROM bank.Client
inner join bank.Application
on Department_idDepartment = Client_idClient
where sum > 5000;

select count(LastName) 
from bank.Client
union all
select count(LastName) 
from bank.Client
inner join bank.Department
on idDepartment = Department_idDepartment 
where DepartmentCity = "Lviv";

select sum, Client_idClient
from bank.Application
left join bank.Client
on Department_idDepartment = Client_idClient
and sum = (select max(sum) from bank.Application
where Client_idClient);

select min(sum), max(sum)
from bank.Application;
