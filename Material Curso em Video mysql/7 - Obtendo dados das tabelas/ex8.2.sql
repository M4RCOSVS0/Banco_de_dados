use cadastro;

/*
 crase e um padrão?
 % igual a nada ou varias coisas
*/

-- Comandos SELECT pt2

-- Seleção por nome
select * from cursos
where nome = 'PHP';

-- usando o Operador LIKE(parecido, semelhante) mostra os nomes semelhantes
select * from cursos
where nome like 'a%';
-- a pq começa com a % e o coringa depois de a tem mais ou nunhum caracter

-- Wildcards
select * from cursos
where nome like '%a';
-- onde tem a no final

-- Wildcards
select * from cursos
where nome like '%a%';
-- onde tem a em qualquer lugar

-- Wildcards
select * from cursos
where nome not like '%a%';
-- onde não tem a em qualquer lugar

-- Wildcards
select * from cursos
where nome like 'ph%p';
-- começa com Ph tem qualquer termina com p

-- Wildcards
select * from cursos
where nome like 'ph%p%';
-- começa com Ph tem qualquer termina com p ou qualquer coisa

-- Wildcards
select * from cursos
where nome like 'ph%p_';
-- começa com Ph tem qualquer coisa depois um p e algum caracter 

select * from cursos
where nome like 'p_p%';
-- começa com p apos um caracter depois outro p e apos qualquer caracter incluindo nenhum

select * from gafanhotos
where nome like '%silva%';
-- que tenha o nome silva em qualquer lugar

select * from gafanhotos
where nome like '%_silva%';
-- que tenha o nome silva com espaço antes

select * from gafanhotos
where nome like 'silva%';
-- que começa com silva

select * from gafanhotos
where nome like '%silva';
-- que termina com silva

-- Distinguindo 
select distinct nacionalidade from gafanhotos
order by nacionalidade;
-- resume os iguais 
select distinct carga from cursos
order by carga;

-- Agregações

-- conta qts tem

select count(*) from cursos;

select count(*) from cursos where carga > 40;

-- descobrir o maior

select max(carga) from cursos;

select max(totaulas) from cursos where ano = 2016;

-- descobrir o menor

select min(carga) from cursos;

select nome, min(totaulas) from cursos where ano = 2016;

-- somar


select sum(totaulas) from cursos;

select sum(totaulas) from cursos where ano = 2016;

-- media
select avg(totaulas) from cursos;

select avg(totaulas) from cursos where ano = 2016;






























