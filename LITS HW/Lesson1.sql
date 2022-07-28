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