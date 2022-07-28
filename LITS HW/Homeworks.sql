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

