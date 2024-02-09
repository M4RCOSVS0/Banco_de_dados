use cadastro;

-- Comando SELECT pt.3



-- Agrupando registros ;
Select carga from cursos
group by carga
order by carga desc;

-- Agrupando & Agregando
select carga, count(nome) from cursos
group by carga;

-- Agrupando totaulas,serve pra contar os iguais
select totaulas,count(*) from cursos
group by totaulas
order by totaulas;

-- Agrupando onde as aulas são igual a 30
select carga, count(nome) from cursos where totaulas = 30
group by carga;

-- having e tipo o where mas para o group, da pra ordenar e filtrar
select ano, count(*) from cursos  where totaulas > 30
group by ano
having ano > 2016
order by count(*) desc;

-- media da duração do curso
select avg(carga) from cursos;


-- juntando select
select carga,count(*) from cursos
where ano > 2015
group by carga
having carga > (select avg(carga) from cursos);

-- Exercícios 2
-- 1ª "Uma lista com as profissões dos gafanhotos e seus respectivos quantitativos"
select profissao,count(*) from gafanhotos
group by profissao
order by profissao;

-- 2ª "Quantos gafanhotos homemns e quantas mulheres nasceram após 01/jan/2005"
select sexo,count(*) from gafanhotos 
where nascimento > '2005-01-01'
group by sexo;

/* 3ª "Uma lista com os gafanhotos que nasceram fora do Brasil, mostrando o país de origem 
e o total de pessoas nascidas lá. Só nos interessam os países que tiveram mais de 3 gafa-
nhotos com essa nacionalidade"*/
select nacionalidade,count(*) from gafanhotos 
where nacionalidade <> 'Brasil'
group by nacionalidade
having count(*) > 3;

/* 4ª "Uma lista agrupada pela altura dos gafanhotos, mostrando quantas pessoas pessam mais
de 100kg e que estão acima da média de altura de todos os cadastrados"*/

-- gambiarra
select SUM(peso > '100' and altura > (select avg(altura) from gafanhotos)) as quantidade from gafanhotos;

-- jeito copiado
select sum(quantidade) as total_quantidade from(
	select count(*) as quantidade from gafanhotos 
	where peso > '100'
	group by altura
	having altura > (select avg(altura) from gafanhotos)
) as subconsulta;

-- fiz asim
select altura, count(*) from gafanhotos
where peso > '100'
group by altura
having altura > (select avg(altura) from gafanhotos)
order by altura;



