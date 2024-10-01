CREATE DATABASE TESTE

USE TESTE

CREATE TABLE TESTE5
(
    CODIGO   INT,
    MENSAGEM VARCHAR(20)
)

CREATE OR ALTER TRIGGER TG_DDL_ALTERACAO_BANCO
    ON DATABASE
    FOR DDL_TABLE_EVENTS
    AS
BEGIN
    RAISERROR ('Remoção e Alteração de Tabelas não são permitidas',1,1)
    ROLLBACK
    RETURN
END

DROP TABLE TESTE;

ALTER TABLE TESTE5
    ADD IDADE INT;

CREATE OR ALTER TRIGGER TG_DDL_ALTERACAO_BANCO
    ON DATABASE
    FOR DDL_TABLE_EVENTS
    AS
BEGIN
    RAISERROR ('Remoção e Alteração de Tabelas não são permitidas',1,1)
    ROLLBACK
    RETURN
END

DROP TABLE TESTE;

ALTER TABLE TESTE
    ADD IDADE INT;

DISABLE TRIGGER TG_DDL_ALTERACAO_BANCO ON DATABASE;


CREATE TABLE TB_LOG_ALTERACOES_ESQUEMA
(
    id_log     int not null primary key
        identity (1,1),
    dt_log     datetime,
    nm_usuario varchar(30),
    evento     nvarchar(100),
    comando    nvarchar(2000)
)

CREATE TRIGGER TG_DDL_ALTERACOES_ESQUEMA
ON DATABASE
FOR DDL_TABLE_EVENTS
AS
BEGIN
    DECLARE @evento XML
    SET @evento = EVENTDATA()
    INSERT INTO TB_LOG_ALTERACOES_ESQUEMA(dt_log,nm_usuario, evento, comando)
    VALUES (GETDATE(),
            CURRENT_USER,
            @evento.value('(/EVENT_INSTANCE/EventType)[1]','nvarchar(100)'),
            @evento.value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(2000)')
    )
END

SELECT * FROM TB_LOG_ALTERACOES_ESQUEMA

