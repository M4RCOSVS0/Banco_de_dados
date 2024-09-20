-- Mantenha um backUp

use cadastro;

-- Lista pessoas cadastradas
select * from cursos;

-- inserindo  dados
insert into cursos values
('1','HTML4','cursos de html5','40','37','2014'),
('2','Algoritmos','Lógica de programação','20','15','2014'),
('3','Photoshop','Dicas de Photoshop CC','10','8','2014'),
('4','PGP','Curso de PHP para iniciantes','40','20','2010'),
('5','Jarva','Introdução a linguagem java','10','29','2000'),
('6','MySQL','Banco de Dados MySQL','30','15','2016'),
('7','Word','curso completo de Word','40','30','2016'),
('8','sapateado','cursos de sapato','40','37','2018'),
('9','cozinha arabe','aprenda a fazer bomba','40','10','2018'),
('10','Youtuber','Gerar polemica e ganhar inscritos','5','2','2018');

-- modificar uma linha
update cursos
set nome = 'HTML5'
where idcursos = '1';

-- modificar uma linha com mais de uma alteração
update cursos
set nome = 'PHP',ano = '2015'
where idcursos = '4';

-- modifica varais linhas com segurança usando limit (limita a uma linha)
update cursos
set nome = 'Java',carga='40',ano = '2015'
where idcursos = '5'
limit 1;

-- problema, vai mudar coisas q talvez vc não queira
update cursos
set ano = '2024',carga = '0'
where ano = '2018'
limit 1;

-- Excluir uma linha
delete from cursos
where ano = '2018'
limit 2;

-- Removendo todas as Linhas de um Tabela
truncate table cursos;