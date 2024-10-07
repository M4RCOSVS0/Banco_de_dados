USE EX012

CREATE TABLE TB_VENDAS
(
    CD_VENDA   INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
    DT_VENDA   DATETIME,
    MATRICULA  INT,
    CD_PRODUTO INT,
    QUANTIDADE NUMERIC(10, 2)
)

CREATE TABLE TB_VENDAS_MENSAL
(
    MATRICULA               INT,
    ANO                     INT,
    MES                     INT,
    QUANTIDADE_MES_ATUAL    NUMERIC(10, 2),
    QUANTIDADE_MES_ANTERIOR NUMERIC(10, 2),
    VARIACAO                NUMERIC(10, 2)
)

INSERT INTO TB_VENDAS
VALUES ('20180101', 10, 1001, 50)
INSERT INTO TB_VENDAS
VALUES ('20180101', 10, 1002, 50)
INSERT INTO TB_VENDAS
VALUES ('20180201', 10, 1001, 150)
INSERT INTO TB_VENDAS
VALUES ('20180101', 30, 1001, 200)
INSERT INTO TB_VENDAS
VALUES ('20180101', 30, 1001, 100)
INSERT INTO TB_VENDAS
VALUES ('20180201', 30, 1001, 150)
INSERT INTO TB_VENDAS
VALUES ('20180501', 40, 1002, 100)
INSERT INTO TB_VENDAS
VALUES ('20180510', 40, 1002, 200)
INSERT INTO TB_VENDAS
VALUES ('20180705', 40, 1001, 250)


CREATE PROCEDURE SP_VENDAS_MENSAL
AS
BEGIN
    DECLARE @MATRICULA INT;
    DECLARE @ANO INT;
    DECLARE @MES INT;
    DECLARE @MES2 INT;
    DECLARE @MES_ATUAL NUMERIC(10, 2);
    DECLARE @MES_ANTERIOR NUMERIC(10, 2);
    DECLARE @VARIACAO NUMERIC(10, 2);
    DECLARE @MES_AUX NUMERIC(10, 2);
    DECLARE @AUX_MAT INT;

    DECLARE C_USUARIO CURSOR FOR
        SELECT
            MATRICULA,
            YEAR(DT_VENDA)  AS Ano,
            MONTH(DT_VENDA) AS Mes,
            SUM(QUANTIDADE) AS MES_ATUAL
        FROM
            TB_VENDAS
        GROUP BY
            MATRICULA, YEAR(DT_VENDA), MONTH(DT_VENDA)

    OPEN C_USUARIO;

    FETCH NEXT FROM C_USUARIO INTO @MATRICULA,@ANO,@MES,@MES_ATUAL

    SET @MES2 = 0;

    WHILE @@FETCH_STATUS = 0
        BEGIN
            IF @MES = 1 AND @ANO = 2018 OR @AUX_MAT <> @MATRICULA OR @MES - @MES2 <> 1
                SET @MES_ANTERIOR = 0
            ELSE
                SET @MES_ANTERIOR = @MES_AUX

            IF @MES_ANTERIOR <> 0
                SET @VARIACAO = (@MES_ATUAL - @MES_ANTERIOR) / @MES_ANTERIOR;
            ELSE
                SET @VARIACAO = 0;

            SET @MES_AUX = @MES_ATUAL;
            SET @AUX_MAT = @MATRICULA;

            INSERT INTO TB_VENDAS_MENSAL
            VALUES (@MATRICULA, @ANO, @MES, @MES_ATUAL, @MES_ANTERIOR, @VARIACAO)

            SET @MES2 = @MES;

            FETCH NEXT FROM C_USUARIO INTO @MATRICULA,@ANO,@MES,@MES_ATUAL
        END

    CLOSE C_USUARIO;
    DEALLOCATE C_USUARIO;
END

SELECT * FROM TB_VENDAS;

SELECT * FROM TB_VENDAS_MENSAL;
