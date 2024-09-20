CREATE DATABASE PROVA

USE PROVA

CREATE TABLE TB_PESSOA(
    NOME        VARCHAR(60)     NOT NULL,
    MATRICULA   INT             NOT NULL  PRIMARY KEY,
    EMAIL       VARCHAR(30)     NOT NULL,
    FUNCAO      VARCHAR(15)     NOT NULL CHECK(FUNCAO IN ('Aluno' , 'Professor'))
)

CREATE TABLE TRABALHA(
    MATRICULA   INT  FOREIGN KEY (MATRICULA) REFERENCES TB_PESSOA(MATRICULA),
    COD_PROJETO INT  FOREIGN KEY (COD_PROJETO) REFERENCES TB_PROJETO(COD_PROJETO),
    PRIMARY KEY (MATRICULA,COD_PROJETO)
)

CREATE TABLE  TB_PROJETO(
    DATA_INICIO     DATETIME    NOT NULL,
    DATA_FIM        DATETIME    NULL,
    COD_PROJETO     INT         NOT NULL PRIMARY KEY,
    NOME            VARCHAR(60) NOT NULL,
    DESCRICAO       VARCHAR(15) NOT NULL
)

CREATE TABLE TB_PRODUTO(
    COD_PRODUTO     INT         NOT NULL PRIMARY KEY,
    NOME            VARCHAR(60) NOT NULL,
    DESCRICAO       VARCHAR(15) NOT NULL,
    TIPO            VARCHAR(12) NOT NULL    CHECK (TIPO IN('Artigo', 'Relatório', 'Software')),
    COD_PROJETO     INT FOREIGN KEY (COD_PROJETO) REFERENCES TB_PROJETO(COD_PROJETO)
)


INSERT INTO TRABALHA (MATRICULA, COD_PROJETO) VALUES
(12345, 1),
(54321, 2),
(12345, 2);

--ok
INSERT INTO TB_PRODUTO (COD_PRODUTO, NOME, DESCRICAO, TIPO, COD_PROJETO) VALUES
(1, 'Produto 1', 'Produto 1', 'Artigo', 1),
(2, 'Produto 2', 'Produto 2', 'Relatório', 2),
(3, 'Produto 3', 'Produto 3', 'Software', 1);


INSERT INTO TB_PROJETO (DATA_INICIO, DATA_FIM, COD_PROJETO, NOME, DESCRICAO) VALUES
('20240101', '20241231', 1, 'Projeto A', 'Projeto A'),
('20240201', '20241130', 2, 'Projeto B', 'Projeto B');

--ok
INSERT INTO TB_PESSOA (NOME, MATRICULA, EMAIL, FUNCAO) VALUES
('João Silva', 12345, 'joao.silva@email.com', 'Aluno'),
('Maria Oliveira', 54321, 'maria.oliveira@email.com', 'Professor');



SELECT
    pj.NOME,
    pj.DESCRICAO,
    pj.DATA_INICIO
FROM
    TB_PROJETO pj
ORDER BY
    pj.DATA_INICIO

SELECT
    PD.NOME,
    TP.DESCRICAO,
    TP.DATA_INICIO
FROM
    TB_PRODUTO PD
JOIN
    TB_PROJETO TP on PD.COD_PROJETO = TP.COD_PROJETO

SELECT
    TP.NOME,
    TP.MATRICULA,
    TP.FUNCAO
FROM
    TB_PROJETO PJ
JOIN
    TRABALHA T on PJ.COD_PROJETO = T.COD_PROJETO
JOIN
    TB_PESSOA TP on TP.MATRICULA = T.MATRICULA
WHERE
    PJ.COD_PROJETO = 2

SELECT
    *
FROM
    TB_PROJETO PJ
WHERE
    PJ.DATA_FIM

SELECT
    *
FROM
    TB_PROJETO
WHERE
    DATA_FIM IS NOT NULL -- Projetos finalizados
    AND COD_PROJETO NOT IN (SELECT DISTINCT COD_PROJETO FROM TB_PRODUTO);