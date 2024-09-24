CREATE DATABASE TG08;

USE TG08;

CREATE TABLE TB_VENDAS
(
    CD_VENDA   INT            NOT NULL IDENTITY (1,1) PRIMARY KEY,
    DT_VENDA   DATETIME       NOT NULL,
    CD_PRODUTO INT            NOT NULL,
    QUANTIDADE INT            NOT NULL,
    VALOR      NUMERIC(10, 2) NOT NULL
)

CREATE OR ALTER TRIGGER TG_INSERCOES_VENDAS
ON TB_VENDAS
AFTER INSERT,UPDATE ,DELETE
AS
BEGIN
    DECLARE @HoraAtual TIME = CONVERT(TIME, GETDATE());
        IF (@HoraAtual >= '12:00:00' AND @HoraAtual < '14:00:00') OR (@HoraAtual >= '18:00:00' AND @HoraAtual < '22:00:00')
        BEGIN
            RAISERROR('TRANSAÇÃO FORA DE HORARIO', 16, 1);
            ROLLBACK;
            RETURN;
        END
end

INSERT INTO TB_VENDAS (dt_venda, cd_produto, quantidade, valor)
VALUES
    (GETDATE(), 1, 5, 2.50),
    (GETDATE(), 2, 5, 3.0);

select * from TB_VENDAS



