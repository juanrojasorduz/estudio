-- DATA DEFINITION LANGUAGE (DDL) -> crear y modificar la estructura de una base de datos
--  SENTENCIAS BASICAS:
--  *CREATE
--  *ALTER
--  *DROP 

create database platzi;

create schema platziblog;

use platzi;

create table platziblog.people (
	person_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
	last_name VARCHAR(255) NULL,
	first_name VARCHAR(255) NULL,
	address VARCHAR(255) NULL,
	city VARCHAR(255) NULL);

set IDENTITY_INSERT platziblog.people ON;

INSERT INTO platziblog.people (person_id, last_name, first_name, address, city) 
VALUES ('1', 'V�squez', 'Israel', 'Calle Famosa Num 1', 'M�xico'),
	   ('2', 'Hern�ndez', 'M�nica', 'Reforma 222', 'M�xico'),
	   ('3', 'Alanis', 'Edgar', 'Central 1', 'Monterrey');


create view platziblog.platzi_view as 
select * from platziblog.people p; 

alter table platziblog.people 
add date_of_birth DATETIME null;

EXEC sp_RENAME 'platziblog.people.date_of_birth', 'date_birth', 'COLUMN';

alter table platziblog.people
drop column date_birth;

drop table platziblog.people; 

drop view platziblog.platzi_view;

use master go;

alter database platzi set single_user with rollback immediate;
 
drop database platzi;


