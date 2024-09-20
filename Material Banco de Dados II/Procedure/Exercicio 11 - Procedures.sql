CREATE TABLE TB_USUARIO (
  CD_USUARIO INT NOT NULL PRIMARY KEY,
  NM_USUARIO VARCHAR(60) NOT NULL,
  CPF INT NULL
)

CREATE TABLE TB_LANCAMENTOS (
   CD_LANCAMENTO INT NOT NULL PRIMARY KEY IDENTITY(1,1),
   MES INT NOT NULL,
   ANO INT NOT NULL,
   CD_USUARIO INT NOT NULL,
   TP_LANCAMENTO VARCHAR(1) CHECK (TP_LANCAMENTO IN ('R', 'D')),
   DESCRICAO VARCHAR(200) NOT NULL,
   VALOR NUMERIC(10,2) NOT NULL
)


CREATE TABLE TB_RESUMO_FINANCEIRO (
   CD_USUARIO INT NOT NULL,
   MES INT NOT NULL,
   ANO INT NOT NULL,
   TOTAL_RECEITAS NUMERIC(10,2) NOT NULL,
   TOTAL_DESPESAS NUMERIC(10,2) NOT NULL,
   PRIMARY KEY(CD_USUARIO, MES, ANO)
)

CREATE   PROCEDURE SP_OBTEM_RESUMO(@CD_USUARIO INT,@MES INT,@ANO INT,@TOT_RECEITAS NUMERIC(10,2) OUTPUT, @TOT_DESPESAS DECIMAL(10,2) OUTPUT)
AS
BEGIN

	SET @TOT_RECEITAS = (SELECT ISNULL(SUM(VALOR),0)

						  FROM TB_LANCAMENTOS

						  WHERE MES = @MES AND

						        ANO = @ANO AND

						        CD_USUARIO = @CD_USUARIO AND

						        TP_LANCAMENTO = 'R')

						

				

	SET @TOT_DESPESAS = (SELECT ISNULL(SUM(VALOR),0)

						  FROM TB_LANCAMENTOS

						  WHERE MES = @MES AND

						        ANO = @ANO AND

						        CD_USUARIO = @CD_USUARIO AND

						        TP_LANCAMENTO = 'D')

END

CREATE   PROCEDURE SP_INCLUI_RESUMO_FINANCEIRO(@ANO INT)

AS

BEGIN

	DECLARE @CD_USUARIO INT;

	DECLARE @MES INT;

	DECLARE @TOT_RECEITAS DECIMAL(10,2);

	DECLARE @TOT_DESPESAS DECIMAL(10,2);

	DECLARE C_USUARIO CURSOR FOR

    SELECT 

    	CD_USUARIO

	FROM 

    	TB_USUARIO 



    OPEN C_USUARIO;



    FETCH NEXT FROM C_USUARIO INTO @CD_USUARIO;



    WHILE @@FETCH_STATUS = 0

    BEGIN 

	    SET @MES = 1;

	    WHILE @MES <= 12

	    BEGIN

	    	EXEC SP_OBTEM_RESUMO @CD_USUARIO,@MES,@ANO,@TOT_RECEITAS OUTPUT ,@TOT_DESPESAS OUTPUT

	    	INSERT INTO TB_RESUMO_FINANCEIRO(CD_USUARIO,MES,ANO,TOTAL_RECEITAS,TOTAL_DESPESAS)

	        VALUES(@CD_USUARIO,@MES,@ANO,@TOT_RECEITAS,@TOT_DESPESAS)

	       	SET @MES = @MES + 1;  

	    END 

	    

	    

	   

       	FETCH NEXT FROM C_USUARIO INTO @CD_USUARIO;

    END



    CLOSE C_USUARIO;

    DEALLOCATE C_USUARIO;

END