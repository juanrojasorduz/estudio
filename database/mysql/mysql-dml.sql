### DATA MANIPULATION LANGUAGE (DML) -> Modificar el contenido de la base de datos
#  SENTENCIAS BASICAS:
#  *INSERT
#  *UPDATE
#  *DELETE
#  *SELECT
#  *MERGE
	
INSERT INTO platziblog.people (last_name, first_name, address, city) 
VALUES ('Hernandez', 'Laura', 'Calle 21', 'Monterrey');

;

update platziblog.people 
set last_name = 'Chavez',city = 'Bogotá'
where person_id = 1 ;

delete from platziblog.people 
where person_id = 4;


select * from platziblog.people where city = 'Monterrey'

