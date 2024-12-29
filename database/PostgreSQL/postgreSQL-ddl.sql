-- DATA DEFINITION LANGUAGE (DDL) -> crear y modificar la estructura de una base de datos
--  SENTENCIAS BASICAS:
--  *CREATE
--  *ALTER
--  *DROP 


create database platzi;


create schema platziblog;


create table platziblog.people (
	person_id SERIAL PRIMARY KEY,
	last_name VARCHAR(255) NULL,
	first_name VARCHAR(255) NULL,
	address VARCHAR(255) NULL,
	city VARCHAR(255) NULL);
	
INSERT INTO platziblog.people (person_id, last_name, first_name, address, city) 
VALUES ('1', 'Vásquez', 'Israel', 'Calle Famosa Num 1', 'México'),
	   ('2', 'Hernández', 'Mónica', 'Reforma 222', 'México'),
	   ('3', 'Alanis', 'Edgar', 'Central 1', 'Monterrey');


create or replace view platzi_view as 
select * from platziblog.people p; 

alter table platziblog.people 
add column date_of_birth timestamp NULL
;


alter table platziblog.people
drop column date_of_birth;


drop view platzi_view;

drop table platziblog.people; 

--drop database platziblog;


