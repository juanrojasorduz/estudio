use TestData;

go
create table estudiantes
(
	id int primary key identity,
	nombre varchar(100)
)
;

go
create table materias
(
	id int primary key identity,
	nombre varchar(10)
)
;

go
create table estudiantesmaterias
(
estudiantesid int,
materiasid int,
constraint fk_estudiantesid foreign key (estudiantesid) references estudiantes(id),
constraint fk_materiasid foreign key (materiasid) references materias(id),
primary key(estudiantesid,materiasid)   --Cada nuevo registro insertado no pude duplicar un registro identico insertado previamente 
)
;

go
insert into testdata.dbo.estudiantes (nombre) 
values ('Juan'),
	   ('Maria'),
	   ('Pedro');	  
;

go
insert into testdata.dbo.materias (nombre) 
values ('Algebra'),
	   ('Geografia'),
	   ('Fisica');	  
;

go
insert into testdata.dbo.estudiantesmaterias (estudiantesid,materiasid) 
values ('1','1'),
	   ('1','2'),
	   ('2','2'),
	   ('2','3'),
	   ('3','1'),
	   ('3','3')
;

go
select top 10 * from testdata.dbo.estudiantes; 

go
select top 10 * from testdata.dbo.materias;

go
select top 10 * from testdata.dbo.estudiantesmaterias;

-- Al no tener un valor de 4 contenido en los campos referenciados por la llave foranea no se insertara el registro
go
INSERT INTO testdata.dbo.estudiantesmaterias (estudiantesid,materiasid) 
VALUES ('4','4')


-- Se elimina primero la tabla que haga referencia a una llave foranea externa
go
drop table testdata.dbo.estudiantesmaterias;

go
drop table testdata.dbo.estudiantes; 

go
drop table testdata.dbo.materias;