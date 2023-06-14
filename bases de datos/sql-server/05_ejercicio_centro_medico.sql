

CREATE TABLE [dbo].[TurnoPaciente](
	[idTurno] [int] NOT NULL,
	[idPaciente] [int] NOT NULL,
	[idMedico] [int] NOT NULL,
 CONSTRAINT [PK_PacienteTurno] PRIMARY KEY CLUSTERED 
(
	[idTurno] ASC,
	[idPaciente] ASC,
	[idMedico] ASC
))
GO



CREATE TABLE [dbo].[Turno](
	[idTurno] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[fechaTurno] [datetime] NULL,
	[estado] [smallint] NULL,
	[observacion] [varchar] (30)
 )
GO



CREATE TABLE [dbo].[Historia](
	[idHistoria] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[fechaHistoria] [datetime] NOT NULL,
	[observacion] [varchar](2000) NULL,
	[fechaAlta] [datetime] NULL)
GO



CREATE TABLE [dbo].[HistoriaPaciente](
	[idHistoria] [int] NOT NULL,
	[idPaciente] [int] NOT NULL,
	[idMedico] [int] NOT NULL,
 CONSTRAINT [PK_HistoriaPaciente] PRIMARY KEY CLUSTERED 
(
	[idHistoria] ASC,
	[idPaciente] ASC,
	[idMedico] ASC
))

GO



CREATE TABLE [dbo].[MedicoEspecialidad](
	[idMedico] [int] NOT NULL,
	[idEspecialidad] [int] NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_MedicoEspecialidad] PRIMARY KEY CLUSTERED 
(
	[idMedico] ASC,
	[idEspecialidad] ASC
))
GO



CREATE TABLE [dbo].[Medico](
	[idMedico] int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[nombre] [varchar](50) NOT NULL,
	[apellido] [varchar](50) NOT NULL)
GO



CREATE TABLE [dbo].[Especialidad](
	[idEspecialidad] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[especialidad] [varchar](30) NULL)
GO



CREATE TABLE [dbo].[Pais](
	[idPais] [char](3) NOT NULL PRIMARY KEY,
	[pais] [varchar](30) NULL)
GO



CREATE TABLE [dbo].[TurnoEstado](
	[idestado] [smallint] NOT NULL PRIMARY KEY,
	[descripcion] [varchar](50) NULL)
GO



CREATE TABLE [dbo].[Paciente](
	[idPaciente] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NULL,
	[apellido] [varchar](50) NULL,
	[fNacimiento] [date] NULL,
	[domicilio] [varchar](50) NULL,
	[idPais] [char](3) NULL,
	[telefono] [varchar](20) NULL,
	[email] [varchar](30) NULL,
	[observacion] [varchar](1000) NULL,
 CONSTRAINT [PK_paciente] PRIMARY KEY CLUSTERED 
(
	[idPaciente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



CREATE TABLE [dbo].[Pago](
	[idpago] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[concepto] [tinyint] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[monto] [money] NOT NULL,
	[estado] [tinyint] NULL,
	[obs] [varchar](1000) NULL
)
GO



CREATE TABLE [dbo].[PagoPaciente](
	[idpago] [int] NOT NULL,
	[idpaciente] [int] NOT NULL,
	[idturno] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[idpago] ASC,
	[idpaciente] ASC,
	[idturno] ASC
))
GO



CREATE TABLE [dbo].[Concepto](
	[idconcepto] [tinyint] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[descripcion] [varchar](100) NULL
)
GO



CREATE TYPE [dbo].[historia] FROM [int] NOT NULL
GO
CREATE TYPE [dbo].[medico] FROM [int] NOT NULL
GO
CREATE TYPE [dbo].[observacion] FROM [varchar](1000) NULL
GO
CREATE TYPE [dbo].[paciente] FROM [int] NOT NULL
GO
CREATE TYPE [dbo].[pais] FROM [char](3) NULL
GO
CREATE TYPE [dbo].[turno] FROM [int] NOT NULL
GO
















