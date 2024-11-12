CREATE DATABASE LAB01;

USE LAB01;

CREATE TABLE TB_DEPARTAMENTO(
    CD_DEPARTAMENTO INT NOT NULL PRIMARY KEY,
    NM_DEPARTAMENTO VARCHAR(20)
)

CREATE TABLE TB_FUNCIONARIO(
    MATRICULA INT PRIMARY KEY NOT NULL,
    CPF VARCHAR(11) UNIQUE  NOT NULL,
    NOME VARCHAR(60) NOT NULL,
    CD_DEPARTAMENTO INT NOT NULL,
    FOREIGN KEY (CD_DEPARTAMENTO) REFERENCES TB_DEPARTAMENTO(CD_DEPARTAMENTO)
);

CREATE TABLE TB_TELEFONE(
    NUMERO VARCHAR(11) NOT NULL,
    MATRICULA INT NOT NULL,
    PRIMARY KEY(NUMERO,MATRICULA),
    FOREIGN KEY (MATRICULA) REFERENCES TB_FUNCIONARIO(MATRICULA)
);

CREATE TABLE TB_CAT_PROBLEMA(
    CD_CATEGORIA INT PRIMARY KEY NOT NULL,
    DESCRICAO VARCHAR(20) NOT NULL
);

CREATE TABLE TB_FAZ_SOLICITACAO(
    STATUS  VARCHAR(15) DEFAULT 'EM ABERTO',
    DT_ABERTURA DATE NOT NULL,
    DT_FECHAMENTO DATE NULL,
    DS_PROBLEMA VARCHAR(20),
    CHECK(
        (STATUS IN ('EM ABERTO') AND DT_FECHAMENTO IS NULL) OR
        (STATUS IN ('FECHADO','CANCELADO') AND DT_FECHAMENTO IS NOT NULL)
    ),
    MATRICULA INT NOT NULL,
    CD_CATEGORIA INT NOT NULL,
    FOREIGN KEY (MATRICULA) REFERENCES TB_FUNCIONARIO(MATRICULA),
    FOREIGN KEY (CD_CATEGORIA) REFERENCES TB_CAT_PROBLEMA(CD_CATEGORIA),
    PRIMARY KEY(MATRICULA,CD_CATEGORIA)
);

CREATE TABLE TB_TERCEIRIZADO(
    MATRICULA INT NOT NULL PRIMARY KEY,
    NOME VARCHAR(60) NOT NULL
)

CREATE TABLE TB_ATENDE(
    MATRICULA INT,
    CD_CATEGORIA INT,
    PRIMARY KEY(MATRICULA,CD_CATEGORIA),
    FOREIGN KEY (MATRICULA) REFERENCES TB_TERCEIRIZADO(MATRICULA),
    FOREIGN KEY (CD_CATEGORIA) REFERENCES TB_CAT_PROBLEMA(CD_CATEGORIA)
)

-- Inserindo dados na tabela de departamentos
INSERT INTO TB_DEPARTAMENTO (CD_DEPARTAMENTO, NM_DEPARTAMENTO) VALUES (1, 'Recursos Humanos');
INSERT INTO TB_DEPARTAMENTO (CD_DEPARTAMENTO, NM_DEPARTAMENTO) VALUES (2, 'TI');
INSERT INTO TB_DEPARTAMENTO (CD_DEPARTAMENTO, NM_DEPARTAMENTO) VALUES (3, 'Financeiro');

-- Inserindo dados na tabela de funcionários
INSERT INTO TB_FUNCIONARIO (MATRICULA, CPF, NOME, CD_DEPARTAMENTO) VALUES (1001, '12345678901', 'João Silva', 1);
INSERT INTO TB_FUNCIONARIO (MATRICULA, CPF, NOME, CD_DEPARTAMENTO) VALUES (1002, '98765432100', 'Maria Souza', 2);
INSERT INTO TB_FUNCIONARIO (MATRICULA, CPF, NOME, CD_DEPARTAMENTO) VALUES (1003, '19283746500', 'Carlos Pereira', 3);

-- Inserindo dados na tabela de telefones
INSERT INTO TB_TELEFONE (NUMERO, MATRICULA) VALUES ('11987654321', 1001);
INSERT INTO TB_TELEFONE (NUMERO, MATRICULA) VALUES ('21912345678', 1002);
INSERT INTO TB_TELEFONE (NUMERO, MATRICULA) VALUES ('31987654321', 1003);

-- Inserindo dados na tabela de categorias de problemas
INSERT INTO TB_CAT_PROBLEMA (CD_CATEGORIA, DESCRICAO) VALUES (1, 'Suporte Técnico');
INSERT INTO TB_CAT_PROBLEMA (CD_CATEGORIA, DESCRICAO) VALUES (2, 'Problema de Hardware');
INSERT INTO TB_CAT_PROBLEMA (CD_CATEGORIA, DESCRICAO) VALUES (3, 'Reclames financeiro');

-- Inserindo dados na tabela de solicitações
INSERT INTO TB_FAZ_SOLICITACAO (STATUS, DT_ABERTURA, DS_PROBLEMA, MATRICULA, CD_CATEGORIA)
VALUES ('EM ABERTO', '2024-11-01', 'Computador não liga', 1001, 1);
INSERT INTO TB_FAZ_SOLICITACAO (STATUS, DT_ABERTURA, DS_PROBLEMA, DT_FECHAMENTO, MATRICULA, CD_CATEGORIA)
VALUES ('FECHADO', '2024-10-20', 'Reembolso de despesa', '2024-10-22', 1003, 3);

-- Inserindo dados na tabela de terceirizados
INSERT INTO TB_TERCEIRIZADO (MATRICULA, NOME) VALUES (2001, 'Lucas Mendes');
INSERT INTO TB_TERCEIRIZADO (MATRICULA, NOME) VALUES (2002, 'Ana Lima');

-- Inserindo dados na tabela de atendimento por terceirizados
INSERT INTO TB_ATENDE (MATRICULA, CD_CATEGORIA) VALUES (2001, 1);
INSERT INTO TB_ATENDE (MATRICULA, CD_CATEGORIA) VALUES (2002, 2);

SELECT * FROM TB_DEPARTAMENTO
SELECT * FROM TB_FUNCIONARIO
SELECT * FROM TB_TELEFONE
SELECT * FROM TB_CAT_PROBLEMA
SELECT * FROM TB_FAZ_SOLICITACAO
SELECT * FROM TB_TERCEIRIZADO

SELECT
    TT.NOME,
    T.DESCRICAO
FROM
    TB_ATENDE
JOIN
    TB_CAT_PROBLEMA T on T.CD_CATEGORIA = TB_ATENDE.CD_CATEGORIA
JOIN
    TB_TERCEIRIZADO TT on TB_ATENDE.MATRICULA = TT.MATRICULA



