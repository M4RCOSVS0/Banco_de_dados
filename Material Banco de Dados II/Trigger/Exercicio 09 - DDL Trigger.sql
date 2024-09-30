CREATE DATABASE TG09;

USE TG09;

CREATE TABLE TB_LOG_AUDITORIA
(
    id_log      int not null primary key identity (1,1),
    dt_log      datetime,
    nm_login    varchar(30),
    nm_usuario  varchar(30),
    banco       nvarchar(100),
    esquema     nvarchar(100),
    nm_objeto   nvarchar(100),
    tipo_objeto nvarchar(100),
    evento      nvarchar(100),
    comando     nvarchar(2000)
)

CREATE OR ALTER TRIGGER TG_DDL_ALTERACOES
ON DATABASE
FOR DDL_TABLE_EVENTS
AS
BEGIN
    DECLARE @EVENTO XML;
    SET @EVENTO = EVENTDATA(); -- Capture the event data
    PRINT CONVERT(NVARCHAR(MAX), @EVENTO);
END;

CREATE TABLE TB_C (
 CD_CARGO INT NOT NULL PRIMARY KEY,
 NM_CARGO VARCHAR(50) NOT NULL
)

SELECT * FROM TB_LOG_AUDITORIA;