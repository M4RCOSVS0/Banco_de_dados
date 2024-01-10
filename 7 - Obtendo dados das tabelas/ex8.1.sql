-- Usa o banco cadastro
use cadastro;

-- Comandos SELECT pt1

/* 	
	DESC como comando é describe
	DESC como parametro e discendents(descendente)   
	resultset resultado de uma consulta	
	query é uma solicitação
	between entre
*/

-- Selecione todos os campos da tabela cursos
select * from cursos;

-- Seleciona todos os cursos da tabela em ordem alfabética (asc é opcional)
select * from cursos
order by nome asc;

-- Seleciona todos os cursos da tabela em ordem alfabética inversa
select * from cursos
order by nome desc;

-- mostra apenas nome carga e ano ordenado por ano depois nome
select ano, nome, carga from cursos
order by ano, nome;

-- Seleciona por linhas 
select * from cursos
where ano = 2016
order by nome;

-- Seleciona por linhas (mostrando apenas nome e carga)
select nome, carga from  cursos
where ano = 2016
order by nome;

-- Seleciona por linhas (mostrando apenas nome,carga e ano onde o ano e menor ou igual a 2015)
select nome, carga,ano from  cursos
where ano <= 2015
order by ano, nome;

-- Seleciona por linhas (mostrando apenas nome,carga e ano onde o ano e diferente a 2015)
select nome, carga,ano from  cursos
where ano <> 2015
order by ano, nome;

-- Selecionando Intervalos (que o ano esteja entre 2014 até 2016)
select nome,ano from  cursos
where ano between 2014 and 2016
order by ano desc, nome asc;

-- Selecionado Valores (de 2014 e de 2016)
select nome, descricao, ano from  cursos
where ano in(2014,2016,2020)
order by ano;

-- Combinado Testes
select nome, carga, totaulas from cursos
where carga > 35 or totaulas < 30
order by carga desc,nome asc ;








