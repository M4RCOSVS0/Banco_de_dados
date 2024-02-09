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


