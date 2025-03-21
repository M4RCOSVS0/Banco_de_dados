CREATE DATABASE LAB02;

USE LAB02;

DROP TABLE TB_FUNCIONARIO;

DROP TABLE  TB_PRODUTO;

DROP TABLE TB_VENDAS;

CREATE TABLE TB_FUNCIONARIO(
	MATRICULA		INT	IDENTITY(1,1)	NOT NULL	PRIMARY KEY,
	NM_FUNCIONARIO	VARCHAR(50)	NOT NULL,
	CPF				VARCHAR(15)	NOT NULL,
	DT_ADMISSAO		DATETIME	NOT NULL
);

CREATE TABLE TB_PRODUTO(
	CD_PRODUTO 		INT IDENTITY(1,1) PRIMARY KEY,
	DS_PRODUTO 		VARCHAR(50) NOT NULL,
	Categoria 		VARCHAR(20) CHECK (Categoria IN ('Alimento', 'Perfumaria', 'Brinquedos')),
	VALOR_ATUAL		NUMERIC(10,2)	 	NOT NULL
);

CREATE TABLE TB_VENDAS(
	CD_VENDA		INT			IDENTITY(1,1) PRIMARY KEY,
	MATRICULA		INT			FOREIGN KEY (MATRICULA) REFERENCES TB_FUNCIONARIO(MATRICULA),
	CD_PRODUTO		INT			FOREIGN KEY (CD_PRODUTO) REFERENCES TB_PRODUTO(CD_PRODUTO),
	QUANTIDADE		INT			NOT NULL,
	VALOR_UNITARIO	NUMERIC(10,2)		NOT NULL,
	DT_VENDAS		DATETIME	NOT NULL,
);


-- Exemplo com ID autoincrementável
INSERT INTO TB_FUNCIONARIO
VALUES 
    ('MARCOS', '100.625.245-26', '20200312'),
    ('LUCAS', '112.643.245-21', '20210309'),
    ('JONAS', '154.654.266-45', '20180711');
   
INSERT INTO TB_PRODUTO (DS_PRODUTO, Categoria, VALOR_ATUAL)
VALUES
    ('CHOCOLATE NESTLE','Alimento',8),
    ('DOCE DE CHOCOLATE NESTLE','Alimento',12),
    ('Lyly','Perfumaria',200),
    ('LEGO','Brinquedos',50)


INSERT INTO  TB_VENDAS(MATRICULA, CD_PRODUTO, QUANTIDADE, VALOR_UNITARIO, DT_VENDAS)
VALUES
	(1,2,2,0.5,'20240503'),
	(2,4,1,3,'20240503'),
	(3,1,3,6,'20240503'),
    (1,3,2,50,'20240503');

--A
SELECT
    MATRICULA,NM_FUNCIONARIO,DT_ADMISSAO AS 'Registro do Funcionário'
FROM
    TB_FUNCIONARIO;

--B
SELECT
    *
FROM
    TB_FUNCIONARIO
WHERE
    TB_FUNCIONARIO.DT_ADMISSAO >= '20100301';

--C
SELECT DISTINCT
    Categoria
FROM
    TB_PRODUTO;

--D
SELECT
    *
FROM
    TB_PRODUTO t
WHERE
    t.DS_PRODUTO LIKE '%CHOCOLATE%'

--E
SELECT
    *
FROM
    TB_VENDAS tv
ORDER BY
    tv.DT_VENDAS DESC;

--F
SELECT
    TP.DS_PRODUTO,
    SUM(TV.QUANTIDADE * TV.VALOR_UNITARIO) AS 'Número de Vendas'
FROM
    TB_VENDAS TV
JOIN
    TB_PRODUTO TP on TV.CD_PRODUTO = TP.CD_PRODUTO
GROUP BY
    TP.DS_PRODUTO;

--G
SELECT 
	tf.NM_FUNCIONARIO  as 'Nome do Fúncionario',
	SUM(TV.QUANTIDADE * TV.VALOR_UNITARIO) AS 'Número de Vendas'
FROM 
	TB_VENDAS tv
JOIN
	TB_FUNCIONARIO tf ON (tv.MATRICULA = tf.MATRICULA)
WHERE
	tv.MATRICULA IN (1, 2)
GROUP BY
    TF.NM_FUNCIONARIO

--H
SELECT 
	tf.NM_FUNCIONARIO  as 'Nome do Fúncionario',
	SUM(TV.QUANTIDADE * TV.VALOR_UNITARIO) AS 'Número de Vendas'
FROM 
	TB_VENDAS tv
JOIN
	TB_FUNCIONARIO tf ON (tv.MATRICULA = tf.MATRICULA) 
WHERE 
	tv.MATRICULA NOT  IN (1)
GROUP BY
    TF.NM_FUNCIONARIO