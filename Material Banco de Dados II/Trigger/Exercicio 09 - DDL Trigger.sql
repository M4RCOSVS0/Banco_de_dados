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
FOR DDL_TABLE_EVENTS, DDL_VIEW_EVENTS, DDL_PROCEDURE_EVENTS
AS
BEGIN
    DECLARE @evento XML
    SET @evento = EVENTDATA()
    INSERT INTO TB_LOG_AUDITORIA(DT_LOG, NM_LOGIN, NM_USUARIO, BANCO, ESQUEMA, NM_OBJETO, TIPO_OBJETO, EVENTO, COMANDO)
    VALUES (GETDATE(),
            @evento.value('(/EVENT_INSTANCE/LoginName)[1]','nvarchar(100)'),
            CURRENT_USER,
            @evento.value('(/EVENT_INSTANCE/DatabaseName)[1]','nvarchar(100)'),
            @evento.value('(/EVENT_INSTANCE/SchemaName)[1]','nvarchar(100)'),
            @evento.value('(/EVENT_INSTANCE/ObjectName)[1]','nvarchar(100)'),
            @evento.value('(/EVENT_INSTANCE/ObjectType)[1]','nvarchar(100)'),
            @evento.value('(/EVENT_INSTANCE/EventType)[1]','nvarchar(100)'),
            @evento.value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(2000)')
    )
END;



SELECT * FROM TB_LOG_AUDITORIA;

create table teste(
    teste int
)

create procedure sp_teste
    as
    begin
        print 'TESTE'
    end

create view vw_teste as
select * from teste

exec sp_teste