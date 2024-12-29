DROP TABLE dbo.persons

GO
CREATE TABLE dbo.persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255) NOT NULL,
    Age int NULL
);

-- Ejecuci�n Exitosa
GO
INSERT INTO dbo.persons VALUES (1020,'Rojas','Juan',NULL)

GO
SELECT ID, LastName, FirstName, Age from dbo.persons;


-- Ejecuci�n Fallida
GO
INSERT INTO dbo.persons VALUES (1020,'Rojas',NULL,NULL)

GO
SELECT ID, LastName, FirstName, Age from dbo.persons;

--resultado ejecuci�n:
--ID	LastName	FirstName	Age
--1020	Rojas		Juan		NULL