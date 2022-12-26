create table estudiantes
(
	id int primary key identity,
	nombre varchar(100)
)

;

create table materias
(
	id int primary key identity,
	nombre varchar(10)
)

;

create table estudiantesmaterias
(
estudiantesid int,
materiasid int,
foreign key (estudiantesid) references estudiantes(id),
constraint fk_materiasid foreign key (materiasid) references materias(id),
primary key(estudiantesid,materiasid)
)

;


select top 10 * from testdata.dbo.estudiantes 

;

select top 10 * from testdata.dbo.materias

;

select top 10 * from testdata.dbo.estudiantesmaterias

;

INSERT INTO testdata.dbo.estudiantes (nombre) 
VALUES ('Juan'),
	   ('Maria'),
	   ('Pedro');
	  
;

INSERT INTO testdata.dbo.materias (nombre) 
VALUES ('Algebra'),
	   ('Geografia'),
	   ('Fisica');	  
;


INSERT INTO testdata.dbo.estudiantesmaterias (estudiantesid,materiasid) 
VALUES ('1','1'),
	   ('1','2'),
	   ('2','2'),
	   ('2','3'),
	   ('3','1'),
	   ('3','3')
;


