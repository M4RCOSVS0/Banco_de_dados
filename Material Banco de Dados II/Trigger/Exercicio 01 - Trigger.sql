CREATE DATABASE TG01;

USE TG01;

CREATE TABLE TB_ALUNO
(
    MATRICULA INT          NOT NULL PRIMARY KEY,
    NOME      VARCHAR(50)  NOT NULL,
    RG        INT          NULL,
    ENDERECO  VARCHAR(100) NULL,
    TELEFONE  VARCHAR(20)  NULL,
)

CREATE TABLE TB_LOG_PENDENCIAS
(
    MATRICULA INT,
    NOME      VARCHAR(50),
    PENDENCIA VARCHAR(200)
)

--1
CREATE OR ALTER TRIGGER TG_INSERT_ALUNO
    ON TB_ALUNO
    AFTER INSERT
    AS
BEGIN

    -- Recuperar informações da linha inserida
    DECLARE @MATRICULA INT;
    DECLARE @NOME VARCHAR(50);
    DECLARE @TELEFONE VARCHAR(20);
    DECLARE @ENDERECO VARCHAR(100);
    DECLARE @RG INT;

    DECLARE C_ALUNO_INSERIDO CURSOR FOR
        SELECT MATRICULA, NOME, TELEFONE, ENDERECO, RG
        FROM INSERTED;
    OPEN C_ALUNO_INSERIDO
    FETCH C_ALUNO_INSERIDO INTO @MATRICULA,@NOME,@TELEFONE,@ENDERECO,@RG;
    WHILE (@@FETCH_STATUS = 0)
        BEGIN
            IF @TELEFONE IS NULL
                BEGIN
                    INSERT INTO TB_LOG_PENDENCIAS (MATRICULA, NOME, PENDENCIA)
                    VALUES (@MATRICULA, @NOME, 'FALTA TELEFONE')
                END
            IF @ENDERECO IS NULL
                BEGIN
                    INSERT INTO TB_LOG_PENDENCIAS (MATRICULA, NOME, PENDENCIA)
                    VALUES (@MATRICULA, @NOME, 'FALTA ENDEREÇO')
                END
            IF @RG IS NULL
                BEGIN
                    INSERT INTO TB_LOG_PENDENCIAS (MATRICULA, NOME, PENDENCIA) VALUES (@MATRICULA, @NOME, 'FALTA RG')
                END
            FETCH C_ALUNO_INSERIDO INTO @MATRICULA,@NOME,@TELEFONE,@ENDERECO,@RG;
        END
    CLOSE C_ALUNO_INSERIDO
    DEALLOCATE C_ALUNO_INSERIDO
END
    CREATE OR ALTER PROCEDURE SP_INCLUIR_ALUNO(@MATRICULA INT, @NOME VARCHAR(50))
    AS
    BEGIN
        INSERT INTO TB_ALUNO(MATRICULA, NOME)
        VALUES (@MATRICULA, @NOME)
    end
        EXEC SP_INCLUIR_ALUNO 4, 'HOKAGE1630';

    SELECT *
    FROM TB_ALUNO;

    SELECT *
    FROM TB_LOG_PENDENCIAS;

    INSERT INTO TB_ALUNO(MATRICULA, NOME)
    VALUES (13, 'guSTA')

--2
 CREATE OR ALTER TRIGGER TG_UPDATE_ALUNO
 ON TB_ALUNO
 AFTER UPDATE
 AS
 BEGIN
    --ADD NOME
    DECLARE @MATRICULA INT;
    DECLARE @TELEFONE VARCHAR(20);
    DECLARE @ENDERECO VARCHAR(100);
    declare @nome varchar(50);
    DECLARE @RG INT;

    DECLARE C_ALUNO_INSERIDO CURSOR FOR
        SELECT MATRICULA, TELEFONE, ENDERECO, RG,NOME
        FROM INSERTED;
    OPEN C_ALUNO_INSERIDO
    FETCH C_ALUNO_INSERIDO INTO @MATRICULA,@TELEFONE,@ENDERECO,@RG,@NOME;
    WHILE (@@FETCH_STATUS = 0)
    BEGIN
        DELETE FROM TB_LOG_PENDENCIAS WHERE MATRICULA = @MATRICULA;
        IF @TELEFONE IS NULL
                BEGIN
                    INSERT INTO TB_LOG_PENDENCIAS (MATRICULA, NOME, PENDENCIA)
                    VALUES (@MATRICULA, @NOME, 'FALTA TELEFONE')
                END
        IF @ENDERECO IS NULL
                BEGIN
                    INSERT INTO TB_LOG_PENDENCIAS (MATRICULA, NOME, PENDENCIA)
                    VALUES (@MATRICULA, @NOME, 'FALTA ENDEREÇO')
                END
        IF @RG IS NULL
                BEGIN
                    INSERT INTO TB_LOG_PENDENCIAS (MATRICULA, NOME, PENDENCIA) VALUES (@MATRICULA, @NOME, 'FALTA RG')
                END
        FETCH C_ALUNO_INSERIDO INTO @MATRICULA,@TELEFONE,@ENDERECO,@RG,@NOME;
    END
    CLOSE C_ALUNO_INSERIDO
    DEALLOCATE C_ALUNO_INSERIDO
END

UPDATE TB_ALUNO
SET ENDERECO = 'São Cristovão'
WHERE MATRICULA = 12

--3
CREATE OR ALTER TRIGGER TG_DELETE_ALUNO
ON TB_ALUNO
AFTER DELETE
AS
BEGIN
    DECLARE @MATRICULA INT;
    DECLARE C_ALUNO_INSERIDO CURSOR FOR
        SELECT MATRICULA
        FROM deleted;
    OPEN C_ALUNO_INSERIDO
    FETCH C_ALUNO_INSERIDO INTO @MATRICULA;
    WHILE (@@FETCH_STATUS = 0)
    BEGIN
        DELETE FROM TB_LOG_PENDENCIAS WHERE MATRICULA = @MATRICULA;
        FETCH C_ALUNO_INSERIDO INTO @MATRICULA;
    END
    CLOSE C_ALUNO_INSERIDO
    DEALLOCATE C_ALUNO_INSERIDO
end

select * from TB_LOG_PENDENCIAS

SELECT * FROM TB_ALUNO;

DELETE FROM TB_ALUNO WHERE MATRICULA = 10;