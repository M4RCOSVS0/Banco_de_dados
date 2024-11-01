CREATE DATABASE AVII22;

USE AVII22;

DROP TABLE IF EXISTS TB_OFERECE_PACOTE_CLIENTE
DROP TABLE IF EXISTS TB_PACOTE_SAIDA
DROP TABLE IF EXISTS TB_PACOTE
DROP TABLE IF EXISTS TB_INTERESSE_CLIENTE
DROP TABLE IF EXISTS TB_DESTINO
DROP TABLE IF EXISTS TB_CLIENTE


CREATE TABLE TB_DESTINO (
   COD_DESTINO		INT NOT NULL PRIMARY KEY,
   DESCRICAO		VARCHAR(100) NOT NULL,
   ESTADO			CHAR(2) NOT NULL
)

INSERT INTO TB_DESTINO (COD_DESTINO, DESCRICAO, ESTADO)
VALUES (1, 'BARRA DE S�O MIGUEL', 'AL')

INSERT INTO TB_DESTINO (COD_DESTINO, DESCRICAO, ESTADO)
VALUES (2, 'PORTO DE GALINHAS','PE')

INSERT INTO TB_DESTINO (COD_DESTINO, DESCRICAO, ESTADO)
VALUES (3, 'PORTO SEGURO','BA')

INSERT INTO TB_DESTINO (COD_DESTINO, DESCRICAO, ESTADO)
VALUES (4, 'SALVADOR','BA')

CREATE TABLE TB_CLIENTE (
   COD_CLIENTE		INT NOT NULL PRIMARY KEY,
   NM_CLIENTE		VARCHAR(50) NOT NULL,
   CPF				VARCHAR(13) NOT NULL,
   TELEFONE_CELULAR VARCHAR(20) NOT NULL,
   EMAIL			VARCHAR(100) NOT NULL
)

INSERT INTO TB_CLIENTE
VALUES(1, 'JOAO', '1111111111111','8804-1771','joao@gmail.com')

INSERT INTO TB_CLIENTE
VALUES(2, 'CARLOS', '2222222222222','8804-1772','carlos@gmail.com')

INSERT INTO TB_CLIENTE
VALUES(3, 'ROBERTA', '4444444444444','8804-1773','roberta@gmail.com')

INSERT INTO TB_CLIENTE
VALUES(4, 'PATRICIA', '5555555555555','8804-1774','patricia@gmail.com')

CREATE TABLE TB_INTERESSE_CLIENTE (
   ID_INTERESSE_CLIENTE INT NOT NULL PRIMARY KEY IDENTITY(1,1),
   COD_DESTINO			INT NOT NULL REFERENCES TB_DESTINO,
   COD_CLIENTE			INT NOT NULL REFERENCES TB_CLIENTE,
   UNIQUE (COD_DESTINO, COD_CLIENTE)
)

INSERT INTO TB_INTERESSE_CLIENTE
VALUES(1,1)

INSERT INTO TB_INTERESSE_CLIENTE
VALUES(2,2)

INSERT INTO TB_INTERESSE_CLIENTE
VALUES(3,2)

CREATE TABLE TB_PACOTE (
    COD_PACOTE		INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    DESCRICAO		VARCHAR(200) NOT NULL,
    COD_DESTINO		INT NOT NULL REFERENCES TB_DESTINO,
    NR_DIAS		    INT NOT NULL CHECK (NR_DIAS > 1),
    DATA_INICIAL    DATETIME NOT NULL,
    DATA_FINAL      DATETIME NOT NULL
)     

CREATE TABLE TB_PACOTE_SAIDA (
    ID_PACOTE_SAIDA INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    COD_PACOTE		INT NOT NULL REFERENCES TB_PACOTE,
    DATA_SAIDA		DATETIME NOT NULL,
    UNIQUE (COD_PACOTE, DATA_SAIDA)
)    
    
CREATE TABLE TB_OFERECE_PACOTE_CLIENTE (
    ID_OFERECE	INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    COD_CLIENTE INT NOT NULL REFERENCES TB_CLIENTE,
    COD_PACOTE	INT NOT NULL REFERENCES TB_PACOTE,
    OFERECIDO	CHAR(3) DEFAULT('NAO') CHECK (OFERECIDO IN ('SIM','NAO')),
	UNIQUE (COD_CLIENTE, COD_PACOTE)
)


-- Testes (Lembrar que poderia ser um �nico insert)

INSERT INTO TB_PACOTE(DESCRICAO, COD_DESTINO, NR_DIAS, DATA_INICIAL, DATA_FINAL)
VALUES('PACOTE BARRA DE SAO MIGUEL',1,4,'20220704', '20220730')

INSERT INTO TB_PACOTE(DESCRICAO, COD_DESTINO, NR_DIAS, DATA_INICIAL, DATA_FINAL)
VALUES('PACOTE PORTO DE GALINHAS',2,5,'20220704', '20220715')

INSERT INTO TB_PACOTE(DESCRICAO, COD_DESTINO, NR_DIAS, DATA_INICIAL, DATA_FINAL)
VALUES('PACOTE SALVADOR',4,5,'20221104', '20221115')

-- Resultado ap�s inclus�o dos Pacotes

SELECT * FROM TB_PACOTE
SELECT * FROM TB_PACOTE_SAIDA
SELECT * FROM TB_OFERECE_PACOTE_CLIENTE


COD_PACOTE  DESCRICAO                                                                                                                                                                                                COD_DESTINO NR_DIAS     DATA_INICIAL            DATA_FINAL
----------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------- ----------- ----------------------- -----------------------
1           PACOTE BARRA DE SAO MIGUEL                                                                                                                                                                               1           4           2022-07-04 00:00:00.000 2022-07-30 00:00:00.000
2           PACOTE PORTO DE GALINHAS                                                                                                                                                                                 2           5           2022-07-04 00:00:00.000 2022-07-15 00:00:00.000
3           PACOTE SALVADOR                                                                                                                                                                                          4           5           2022-11-04 00:00:00.000 2022-11-15 00:00:00.000

(3 rows affected)

ID_PACOTE_SAIDA COD_PACOTE  DATA_SAIDA
--------------- ----------- -----------------------
1               1           2022-07-04 00:00:00.000
2               1           2022-07-10 00:00:00.000
3               1           2022-07-16 00:00:00.000
4               1           2022-07-22 00:00:00.000
5               1           2022-07-28 00:00:00.000
6               2           2022-07-04 00:00:00.000
7               2           2022-07-11 00:00:00.000
8               3           2022-11-04 00:00:00.000
9               3           2022-11-11 00:00:00.000

(9 rows affected)

ID_OFERECE  COD_CLIENTE COD_PACOTE  OFERECIDO
----------- ----------- ----------- ---------
1           1           1           NAO
2           3           1           NAO
3           4           1           NAO
4           2           2           NAO
5           3           2           NAO
6           4           2           NAO
7           3           3           NAO
8           4           3           NAO

(8 rows affected)

-- Teste de Atualiza��o

UPDATE TB_PACOTE
SET DATA_FINAL = '20220720'
WHERE COD_PACOTE = 1

-- Resultado ap�s atualiza��o

SELECT * FROM TB_PACOTE
SELECT * FROM TB_PACOTE_SAIDA
SELECT * FROM TB_OFERECE_PACOTE_CLIENTE

COD_PACOTE  DESCRICAO                                                                                                                                                                                                COD_DESTINO NR_DIAS     DATA_INICIAL            DATA_FINAL
----------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------- ----------- ----------------------- -----------------------
1           PACOTE BARRA DE SAO MIGUEL                                                                                                                                                                               1           4           2022-07-04 00:00:00.000 2022-07-20 00:00:00.000
2           PACOTE PORTO DE GALINHAS                                                                                                                                                                                 2           5           2022-07-04 00:00:00.000 2022-07-15 00:00:00.000
3           PACOTE SALVADOR                                                                                                                                                                                          4           5           2022-11-04 00:00:00.000 2022-11-15 00:00:00.000

(3 rows affected)

ID_PACOTE_SAIDA COD_PACOTE  DATA_SAIDA
--------------- ----------- -----------------------
10              1           2022-07-04 00:00:00.000
11              1           2022-07-10 00:00:00.000
12              1           2022-07-16 00:00:00.000
6               2           2022-07-04 00:00:00.000
7               2           2022-07-11 00:00:00.000
8               3           2022-11-04 00:00:00.000
9               3           2022-11-11 00:00:00.000

(7 rows affected)

ID_OFERECE  COD_CLIENTE COD_PACOTE  OFERECIDO
----------- ----------- ----------- ---------
1           1           1           NAO
2           3           1           NAO
3           4           1           NAO
4           2           2           NAO
5           3           2           NAO
6           4           2           NAO
7           3           3           NAO
8           4           3           NAO

(8 rows affected)

--1
CREATE OR ALTER TRIGGER TG_INSERCAO_DATA_SAIDA
ON TB_PACOTE
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @COD_PACOTE INT;
    DECLARE @NR_DIAS INT;
    DECLARE @DATA_INICIAL DATETIME;
    DECLARE @DATA_FINAL DATETIME;
    DECLARE @N INT;
    DECLARE @DATA_SAIDA DATETIME;

    DECLARE C_VIAGENS CURSOR FOR
        SELECT COD_PACOTE, NR_DIAS, DATA_INICIAL, DATA_FINAL
        FROM inserted;

    OPEN C_VIAGENS;
    FETCH C_VIAGENS INTO @COD_PACOTE, @NR_DIAS, @DATA_INICIAL, @DATA_FINAL;

    WHILE (@@FETCH_STATUS = 0)
    BEGIN
        SET @DATA_SAIDA = @DATA_INICIAL;

        SET @N = 1;

        WHILE (@N <> 0)
        BEGIN
            IF @DATA_SAIDA <= @DATA_FINAL
            BEGIN
                INSERT INTO TB_PACOTE_SAIDA(COD_PACOTE, DATA_SAIDA)
                VALUES(@COD_PACOTE, @DATA_SAIDA);

                SET @DATA_SAIDA = DATEADD(DAY, @NR_DIAS + 2, @DATA_SAIDA);
            END
            ELSE
            BEGIN
                SET @N = 0;
            END
        END

        FETCH C_VIAGENS INTO @COD_PACOTE, @NR_DIAS, @DATA_INICIAL, @DATA_FINAL;
    END

    CLOSE C_VIAGENS;
    DEALLOCATE C_VIAGENS;
END;

--2
CREATE OR ALTER TRIGGER TG_OFERECE_PACOTE
ON TB_PACOTE
AFTER INSERT
AS
BEGIN
    DECLARE @COD_CLIENTE INT;
    DECLARE @COD_PACOTE	INT;
    DECLARE @OFERECIDO	CHAR(3);

    
end

