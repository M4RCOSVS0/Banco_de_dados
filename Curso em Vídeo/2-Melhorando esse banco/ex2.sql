
-- Criando o banco 
create database cadastro

-- Definição da região
default character set utf8
default collate utf8_general_ci; 

-- Definindo tabela com chave primária
create table pessoas(
id int not null auto_increment,
nome varchar(30) not null,
nascimento date,
sexo enum('M','F'),
peso decimal(5,2),
altura decimal(3,2),
nacionalidade varchar(20) default 'Brasil',
primary key(id)
)default charset = utf8;
