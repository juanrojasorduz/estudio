--Ejecución Exitosa
use TestData

go
drop table dbo.estudiantes_colegio

go
create table dbo.estudiantes_colegio
(
	id int primary key identity,
	nombre varchar(100)
)
;
go
insert into dbo.estudiantes_colegio values ('Juan'),('Maria'),('Pedro')

go
select id, nombre from dbo.estudiantes_colegio

--Resultado
--id	nombre
--1	Juan
--2	Maria
--3	Pedro