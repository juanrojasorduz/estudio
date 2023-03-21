--- Crear Tabla paciente usando idpaciente como llave primaria

CREATE TABLE [dbo].[Paciente1](
	[idpaciente] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[apellido] [varchar](50) NULL,
	[fnacimiento] [date] NULL,
	[domicilio] [varchar](50) NULL,
	[idpais] [char](3) NULL,
	[telefono] [varchar](30) NULL,
	[email] [varchar](30) NULL,
	[observacion] [varchar](1000) NULL,
	[fechaAlta] [datetime] NOT NULL,
	CONSTRAINT [PK_idpaciente] PRIMARY KEY ([idpaciente])
);


CREATE TABLE [dbo].[Historia](
	[idHistoria] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[fechaHistoria] [datetime] NOT NULL,
	[observacion] [varchar](2000) NULL,
	[fechaAlta] [datetime] NULL
);


CREATE TABLE [dbo].[HistoriaPaciente](
	[idHistoria] [int] NOT NULL,
	[idPaciente] [int] NOT NULL,
	[idMedico] [int] NOT NULL,
 CONSTRAINT [PK_HistoriaPaciente] PRIMARY KEY CLUSTERED 
(
	[idHistoria] ASC,
	[idPaciente] ASC,
	[idMedico] ASC)
);


CREATE TABLE [dbo].[Turno](
	[idTurno] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[fechaTurno] [datetime] NULL,
	[estado] [smallint] NULL,
	[observacion] [varchar] (30)
 );


CREATE TABLE [dbo].[TurnoPaciente](
	[idTurno] [int] NOT NULL,
	[idPaciente] [int] NOT NULL,
	[idMedico] [int] NOT NULL,
 CONSTRAINT [PK_PacienteTurno] PRIMARY KEY CLUSTERED 
(
	[idTurno] ASC,
	[idPaciente] ASC,
	[idMedico] ASC
));


CREATE TABLE [dbo].[TurnoEstado](
	[idestado] [smallint] NOT NULL PRIMARY KEY,
	[descripcion] [varchar](50) NULL);


INSERT INTO TurnoEstado VALUES(0, 'Pendiente');
INSERT INTO TurnoEstado VALUES(1, 'Realizado');
INSERT INTO TurnoEstado VALUES(2, 'Cancelado');


CREATE TABLE [dbo].[Pais](
	[idPais] [char](3) NOT NULL PRIMARY KEY,
	[pais] [varchar](30) NULL);


CREATE TABLE [dbo].[Especialidad](
	[idEspecialidad] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[especialidad] [varchar](30) NULL);


CREATE TABLE [dbo].[MedicoEspecialidad](
	[idMedico] [int] NOT NULL,
	[idEspecialidad] [int] NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_MedicoEspecialidad] PRIMARY KEY CLUSTERED 
(
	[idMedico] ASC,
	[idEspecialidad] ASC
));


CREATE TABLE [dbo].[Medico](
	[idMedico] int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[nombre] [varchar](50) NOT NULL,
	[apellido] [varchar](50) NOT NULL);


CREATE TABLE [dbo].[Pago](
	[idpago] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[concepto] [tinyint] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[monto] [money] NOT NULL,
	[estado] [tinyint] NULL,
	[obs] [varchar](1000) NULL
);


CREATE TABLE [dbo].[PagoPaciente](
	[idpago] [int] NOT NULL,
	[idpaciente] [int] NOT NULL,
	[idturno] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idpago] ASC,
	[idpaciente] ASC,
	[idturno] ASC
));


CREATE TABLE [dbo].[Concepto](
	[idconcepto] [tinyint] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[descripcion] [varchar](100) NULL
);

















