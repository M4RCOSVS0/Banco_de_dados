use cadastro;

-- Criando uma tabela extra
create table gafanhoto_assiste_curso(
	id int not null auto_increment,
    data date,
    idgafanhoto int,
    idcurso int,
    primary key (id),
    foreign key(idgafanhoto) references gafanhotos(id),
    foreign key(idcurso) references cursos(idcurso)
)default charset = utf8;

-- Inserindo os Registros
insert into gafanhoto_assiste_curso values
(default, '2014-03-01','1','2');

-- Mostra na tela
select * from gafanhoto_assiste_curso;

-- Juncões 
select g.nome,c.nome from gafanhotos g
join gafanhoto_assiste_curso  a
on g.id = a.idgafanhoto
join cursos c
on  c.idcurso = a.idcurso
order by g.nome;

