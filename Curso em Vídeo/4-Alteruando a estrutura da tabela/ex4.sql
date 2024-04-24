-- Mostra a tabela 
desc teste;

-- Mostra os dados 
select * from teste;

-- Adiciona ao final
alter table pessoas
add column profissao varchar(10); 

-- Adiciona depois de nome
alter table pessoas
add column profissao varchar(10) after nome; 

-- Adciona como primeiro
alter table pessoas
add codigo int first; 
-- Column e OPCIONAL

-- Remove profissão
alter table pessoas
drop column profissao;

-- Modifica o tamanho
alter table pessoas
modify column  profissao varchar(20) not null default '';

-- Modoficar o nome da coluna
alter table pessoas
change column profissao prof varchar(20);

-- Altera o nome da tabela
alter table gafonhotos
rename to gafanhotos;

-- Criando uma nova tabela com condições
create table if not exists cursos(
	nome varchar(30) not null unique,
    descricao text,
	carga int unsigned,
	totAulas int unsigned,
    ano year default '2023'
)default charset = utf8;

-- Add idcursos em cursos
alter table cursos
add column idcursos int first;

-- add key in cursos
alter table cursos
add primary key (idcursos); 

-- Apagar tabela inteiras
create table if not exists teste(
	id int,
    nome varchar(10),
    idade int
)default charset = utf8;

-- add registros
insert into teste value
('1','pedro','22'),
('2','Ana','12'),
('3','Paulo','42');

-- Apagando a tabela eo conteudo
drop table if exists teste;





