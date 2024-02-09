use cadastro;

-- Engine InnoDb mecanismo de criação de tabelas com suporte a chaves extrangeiras

/*
	transação - toda ação que bd possa executar
    4 regras
    ACID
    Atomissidade- ou tudo e feito ou nada e feito
    Consistenência - se antes estava Ok, depois deve estar ok 
    Isolamento - coisas paralelas não podem se interferir
    Durabilidade - durar o tempo que for necessário
*/

describe gafanhotos;
-- Mul == chave multipla(extrangeira)

-- Adiciona a Foregin key
alter table gafanhotos add cursopreferido int;

-- adciona chave extrangeira
alter table gafanhotos
add foreign key (cursopreferido)
references cursos(idcurso);

select * from gafanhotos;
select * from cursos;

update gafanhotos set cursopreferido = '6' where id = '1';
-- atualize o gafanhoto para o curso preferido igual a seis e o id seja 1

-- Integridade refer~encial

delete from cursos where idcurso = '6';
-- não porquê gera inconcistencia

delete from cursos where idcurso = '28';
-- não gera inconcistencia
/*
se apagar um campo gera incosistencia não podera ser excluído
*/
