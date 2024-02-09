use cadastro;

select nome, cursopreferido from gafanhotos;
select nome, ano from curso;

select * from gafanhotos;

-- Junções Inner join
-- as faz um APELIDO 
select g.nome, c.nome, c.ano 
from gafanhotos as g inner join cursos as c
on c.idcurso = g.cursopreferido
order by g.nome; 

-- Junções outer join
-- as faz um APELIDO 
select g.nome, c.nome, c.ano 
from gafanhotos as g left outer join cursos as c
on c.idcurso = g.cursopreferido
order by g.nome; 

-- Junções outer join
-- as faz um APELIDO 
select g.nome, c.nome, c.ano 
from gafanhotos as g right outer join cursos as c
on c.idcurso = g.cursopreferido
order by c.nome; 

