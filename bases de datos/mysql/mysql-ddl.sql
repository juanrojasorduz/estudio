### DATA DEFINITION LANGUAGE (DDL) -> crear y modificar la estructura de una base de datos
#  SENTENCIAS BASICAS:
#  *CREATE
#  *ALTER
#  *DROP 

create schema platziblog;

use platziblog;

create table platziblog.people (
	person_id INT NOT NULL AUTO_INCREMENT,
	last_name VARCHAR(255) NULL,
	first_name VARCHAR(255) NULL,
	address VARCHAR(255) NULL,
	city VARCHAR(255) NULL,
	PRIMARY KEY(person_id));
	
INSERT INTO platziblog.people (person_id, last_name, first_name, address, city) 
VALUES ('1', 'V�squez', 'Israel', 'Calle Famosa Num 1', 'M�xico'),
	   ('2', 'Hern�ndez', 'M�nica', 'Reforma 222', 'M�xico'),
	   ('3', 'Alanis', 'Edgar', 'Central 1', 'Monterrey');


create or replace view platzi_view as 
select * from platziblog.people p; 

alter table platziblog.people 
add column date_of_birth DATETIME null after CITY;

alter table platziblog.people 
change column date_of_birth date_of_birth VARCHAR(30) null default null;

alter table platziblog.people
drop column date_of_birth;

drop table platziblog.people; 

drop view platzi_view;

drop database platziblog;