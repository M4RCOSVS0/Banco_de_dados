use cadastro;



-- 1ª "Uma lista com o nome de todas as gafanhotas"
select * from gafanhotos 
where sexo = 'F'; 

/* 2ª "Uma lista com todos os dados de todos 
aqueles que nasceram entre 1/Jan/2000 e 31/Dez/2015"*/

select * from gafanhotos
where nascimento >= '2000-01-01' and nascimento <= '2015-12-31'
order by nascimento;

-- 3ª "Uma lista de todos os homens que trabalham como programadores"
select * from gafanhotos 
where sexo = 'M' and profissao = 'Programador'
order by nome;  

/* 4ª "Uma lista com os dados de todas as mulheres que nasceram no Brasil 
e que têm seu nome iniciado com a letra J"*/
select * from gafanhotos 
where sexo = 'F' and nacionalidade = 'Brasil' and nome like 'j%'; 

/* 5ª "Uma lista com o nome e nacionalidade de todos os homens que 
têm Silva no nome, não nasceram no Brasil e pesam menos de 100kg"*/
select nome, nacionalidade from gafanhotos 
where nome like '%silva%' and peso < 100 and nacionalidade <> 'Brasil' and sexo = 'M'; 

-- 6ª "Qual é a mair altura entre os gafanhotos homens que moram no Brasil?"
select max(altura) from gafanhotos where sexo = 'M';

-- 7ª "Qual a nedia de pesos dos gafanhotos cadastrados?"
select avg(peso) from gafanhotos;

/* 8ª "Qual é o menor peso entre as gafanhotos mulheres que nasceram 
fora do brasil e entre 01/Jan/1990 e 31/Dez/2000?" */
select min(peso) from gafanhotos 
where sexo = 'F' and nascimento >= '1990-01-01' and nascimento <= '2000-12-31'
and nacionalidade <> 'Brasil';  

-- 9ª "Quantoas gafanhotos mulheres têm mais de 1.90 de altura?"
select nome,altura from gafanhotos 
where sexo = 'F' and altura > 1.9  
order by altura desc;






