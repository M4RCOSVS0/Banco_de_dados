-- Script para os Labs 05 e 05.1
-- Objetivo: Criação do Esquema de Locadora de DVDs

CREATE DATABASE lab05

use lab05
-- 1) Criação do Esquema

--DROP TABLE TB_ALUGUEL
--DROP TABLE TB_DVD
--DROP TABLE TB_CATEGORIA
--DROP TABLE TB_USUARIO

CREATE TABLE TB_USUARIO (
  cd_usuario int not null,
  nm_usuario varchar(50) not null,
  dt_cadastro datetime default(getdate()),
  st_usuario varchar(10) not null
)

ALTER TABLE TB_USUARIO ADD CONSTRAINT PK_USUARIO
PRIMARY KEY (cd_usuario)

ALTER TABLE TB_USUARIO ADD CONSTRAINT CK_ST_USUARIO
CHECK (ST_USUARIO IN ('ATIVO','CANCELADO'))

CREATE TABLE TB_CATEGORIA (
   cd_categoria int not null,
   nm_categoria varchar(50) not null,
   vl_aluguel numeric(15,2)
)

ALTER TABLE TB_CATEGORIA ADD CONSTRAINT PK_CATEGORIA
PRIMARY KEY (cd_categoria)

ALTER TABLE TB_CATEGORIA ADD CONSTRAINT UQ_CATEGORIA_NOME
UNIQUE (nm_categoria)

ALTER TABLE TB_CATEGORIA ADD CONSTRAINT CK_VL_ALUGUEL
CHECK (VL_ALUGUEL > 0)

CREATE TABLE TB_DVD (
   cd_dvd int not null,
   titulo varchar(50) not null,
   cd_categoria int null
)
   
ALTER TABLE TB_DVD ADD CONSTRAINT PK_DVD
PRIMARY KEY (cd_dvd)

ALTER TABLE TB_DVD ADD CONSTRAINT FK_TB_DVD_CD_CATEGORIA
FOREIGN KEY (cd_categoria) REFERENCES TB_CATEGORIA (cd_categoria)

CREATE TABLE TB_ALUGUEL (
   cd_usuario int not null,
   cd_dvd     int not null,
   dt_aluguel datetime not null,
   dt_devolucao datetime not null,
   dt_devolvido datetime null,
   valor_aluguel numeric (15,2) not null,
   valor_multa  numeric (15,2) null,
   st_pagamento varchar(10) not null
)

ALTER TABLE TB_ALUGUEL ADD CONSTRAINT PK_ALUGUEL
PRIMARY KEY (cd_usuario, cd_dvd, dt_aluguel)

ALTER TABLE TB_ALUGUEL ADD CONSTRAINT FK_TB_ALUGUEL_CD_USUARIO
FOREIGN KEY (cd_usuario) REFERENCES TB_USUARIO (cd_usuario)

ALTER TABLE TB_ALUGUEL ADD CONSTRAINT FK_TB_ALUGUEL_CD_DVD
FOREIGN KEY (cd_dvd) REFERENCES TB_DVD (cd_dvd)

ALTER TABLE TB_ALUGUEL ADD CONSTRAINT CK_ST_PAGAMENTO
CHECK (ST_PAGAMENTO IN ('PAGO','NÃO PAGO'))

-- 2) Inserção de dados

-- Tabela de Usuarios


INSERT INTO TB_USUARIO (cd_usuario,nm_usuario,dt_cadastro,st_usuario)
VALUES (1, 'PEDRO', '20190101', 'CANCELADO')

INSERT INTO TB_USUARIO (cd_usuario,nm_usuario,dt_cadastro,st_usuario)
VALUES (2, 'JOAO', '20180201', 'ATIVO')

INSERT INTO TB_USUARIO (cd_usuario,nm_usuario,dt_cadastro,st_usuario)
VALUES (3, 'RENATA', '20180204', 'ATIVO')


-- Tabela de Categorias

INSERT INTO TB_CATEGORIA (cd_categoria, nm_categoria, vl_aluguel)
VALUES(1, 'NORMAL', 2.00)

INSERT INTO TB_CATEGORIA (cd_categoria, nm_categoria, vl_aluguel)
VALUES(2, 'LANCAMENTO', 3.00)

-- Tabela de DVDs

INSERT INTO TB_DVD (cd_dvd, titulo, cd_categoria)
VALUES (1001, 'MESTRE DAS ARMAS', 2)

INSERT INTO TB_DVD (cd_dvd, titulo, cd_categoria)
VALUES (1002, 'SOCIEDADE DOS POETAS MORTOS', 1)

INSERT INTO TB_DVD (cd_dvd, titulo, cd_categoria)
VALUES (1003, 'PERFUME DE MULHER', 1)
   
INSERT INTO TB_DVD (cd_dvd, titulo, cd_categoria)
VALUES (1004, 'JERRY LEWIS', 1)


-- Tabela de Alugueis

INSERT INTO TB_ALUGUEL (cd_usuario, cd_dvd, dt_aluguel, dt_devolucao, 
                        dt_devolvido, valor_aluguel, st_pagamento)
VALUES (2, 1001, '20190201','20190203','20190203', 3.00, 'PAGO')

INSERT INTO TB_ALUGUEL (cd_usuario, cd_dvd, dt_aluguel, dt_devolucao,
                        dt_devolvido, valor_aluguel, st_pagamento)
VALUES (2, 1002, '20190601','20190605',NULL, 2.00, 'PAGO')

INSERT INTO TB_ALUGUEL (cd_usuario, cd_dvd, dt_aluguel, dt_devolucao,
                        dt_devolvido, valor_aluguel, st_pagamento)
VALUES (3, 1003, '20190601','20190605',NULL, 2.00, 'PAGO')



