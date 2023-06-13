--DROP TABLE dbo.MyTable 

CREATE TABLE dbo.MyTable  
(  
  MyDecimalColumn DECIMAL(6,3)  
,MyNumericColumn NUMERIC(6,3)
,MyVarcharColumn VARCHAR(10)
,MyIntColumn INT
,MyBigIntColumn BIGINT
,MyDateColumn DATE
,MyTimeColumn TIME
,MyDateTimeColumn DATETIME
);  
  
GO  
INSERT INTO dbo.MyTable VALUES (123.123, 123.1, 'abcderfghi', 2147483647, 9223372036854775807, '2021-12-01', '23:59:59.9999999', '2007-05-08 12:35:29.123');  

GO  
SELECT MyDecimalColumn, MyNumericColumn, MyVarcharColumn, MyIntColumn, MyBigIntColumn, MyDateColumn, MyTimeColumn, MyDateTimeColumn   
FROM dbo.MyTable;

--------
MyDecimalColumn	MyNumericColumn	MyVarcharColumn	MyIntColumn	MyBigIntColumn	MyDateColumn	MyTimeColumn	MyDateTimeColumn
123.123	123.100	abcderfghi	2147483647	9223372036854775807	2021-12-01	23:59:59.9999999	2007-05-08 12:35:29.123
--------


-- Insercion Fallida: Los datos insertados incumplen la definicion previa del tipo de dato para cada campo de la tabla
GO  
INSERT INTO dbo.MyTable VALUES (12345.12, 12345.12, 'abcderfghia', 2147483648, 9223372036854775808, '01-2024-12', '24:00:00.9999999', '2007-05-08 24:00:00.0000'); 