create database bd_avaliacaoIII

use bd_avaliacaoIII

CREATE TABLE TB_ALUNO
(
    MATRICULA INT          NOT NULL PRIMARY KEY,
    NM_ALUNO  VARCHAR(100) NOT NULL
)

INSERT INTO TB_ALUNO
VALUES (10, 'JOAO'),
       (20, 'RICARDO'),
       (30, 'PATRICIA'),
       (40, 'ROBERTO')

CREATE TABLE TB_DISCIPLINA
(
    CD_DISCIPLINA INT          NOT NULL PRIMARY KEY,
    NM_DISCIPLINA VARCHAR(100) NOT NULL,
    ANO           INT          NOT NULL,
    UNIQUE (NM_DISCIPLINA, ANO)
)

INSERT INTO TB_DISCIPLINA
VALUES (1, 'BD I', 2021),
       (2, 'BD II', 2022),
       (3, 'ES I', 2021),
       (4, 'ES II', 2022),
       (5, 'REDES', 2021)

CREATE TABLE TB_AVALIACAO_DISCIPLINA
(
    CD_DISCIPLINA INT            NOT NULL REFERENCES TB_DISCIPLINA,
    MATRICULA     INT            NOT NULL REFERENCES TB_ALUNO,
    NOTA_FINAL    NUMERIC(10, 1) NOT NULL,
    NR_FALTAS     INT            NOT NULL,
    PRIMARY KEY (CD_DISCIPLINA, MATRICULA)
)

-- BDI
INSERT INTO TB_AVALIACAO_DISCIPLINA
VALUES (1, 10, 10.0, 0),
       (1, 20, 9.0, 11),
       (1, 30, 9.0, 2),
       (1, 40, 8.0, 2)

-- BDII
INSERT INTO TB_AVALIACAO_DISCIPLINA
VALUES (2, 10, 10.0, 0),
       (2, 20, 10.0, 1),
       (2, 30, 10.0, 2),
       (2, 40, 10.0, 11)

-- ES I
INSERT INTO TB_AVALIACAO_DISCIPLINA
VALUES (3, 10, 7.0, 0),
       (3, 20, 7.0, 1),
       (3, 30, 7.0, 2),
       (3, 40, 5.0, 2)
-- ES II
INSERT INTO TB_AVALIACAO_DISCIPLINA
VALUES (4, 10, 4.0, 0),
       (4, 20, 5.0, 1),
       (4, 30, 5.0, 2),
       (4, 40, 4.0, 2)

--1
SELECT
    TA.MATRICULA,
    TA.NM_ALUNO,
    AD.NOTA_FINAL
FROM
    TB_AVALIACAO_DISCIPLINA AD
JOIN
    TB_ALUNO TA on AD.MATRICULA = TA.MATRICULA
JOIN
    TB_DISCIPLINA TD on AD.CD_DISCIPLINA = TD.CD_DISCIPLINA
WHERE
    TD.NM_DISCIPLINA = 'BD I' AND TD.ANO = 2021

--2
SELECT
    TD.CD_DISCIPLINA,
    TD.NM_DISCIPLINA,
    TD.ANO,
    AVG(AD.NOTA_FINAL) AS 'MEDIA_DA_TURMA'
FROM
    TB_AVALIACAO_DISCIPLINA AD
JOIN
    TB_DISCIPLINA TD on AD.CD_DISCIPLINA = TD.CD_DISCIPLINA
GROUP BY
    TD.CD_DISCIPLINA, TD.NM_DISCIPLINA, TD.ANO

--3
SELECT
    TD.CD_DISCIPLINA,
    TD.NM_DISCIPLINA,
    TD.ANO,
    AVG(AD.NOTA_FINAL) AS 'MEDIA_DA_TURMA'
FROM
    TB_AVALIACAO_DISCIPLINA AD
JOIN
    TB_DISCIPLINA TD on AD.CD_DISCIPLINA = TD.CD_DISCIPLINA
GROUP BY
    TD.CD_DISCIPLINA, TD.NM_DISCIPLINA, TD.ANO
HAVING
    AVG(AD.NOTA_FINAL) < 5

--4
SELECT
    TA.MATRICULA,
    TA.NM_ALUNO,
    TD.NM_DISCIPLINA,
    TD.ANO,
    AD.NOTA_FINAL,
    AD.NR_FALTAS
FROM
    TB_AVALIACAO_DISCIPLINA AD
JOIN
    TB_ALUNO TA on AD.MATRICULA = TA.MATRICULA
JOIN
    TB_DISCIPLINA TD on AD.CD_DISCIPLINA = TD.CD_DISCIPLINA
WHERE
    AD.NOTA_FINAL > 7 AND AD.NR_FALTAS > 10

--5
SELECT
    TD.ANO,
    COUNT(TD.NM_DISCIPLINA) AS 'TOTAL DE TURMAS'
FROM
    TB_DISCIPLINA TD
GROUP BY
    TD.ANO
ORDER BY
    TD.ANO DESC

--6
SELECT
    TD.ANO,
    COUNT(TD.NM_DISCIPLINA) AS 'TOTAL DE TURMAS'
FROM
    TB_DISCIPLINA TD
GROUP BY
    TD.ANO
HAVING
     COUNT(TD.NM_DISCIPLINA) >= ALL (
                                    SELECT
                                        COUNT(NM_DISCIPLINA)
                                    FROM
                                        TB_DISCIPLINA
                                    GROUP BY
                                        ANO
                                    )