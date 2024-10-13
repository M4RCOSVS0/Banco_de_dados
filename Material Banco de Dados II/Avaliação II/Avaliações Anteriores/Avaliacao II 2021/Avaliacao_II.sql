CREATE DATABASE AVII21;

USE AVII21;

create table tb_surfista (
   id_surfista int not null,
   nome_surfista varchar(100) not null
)

insert into tb_surfista values(10, 'GABRIEL MEDINA')
insert into tb_surfista values(17, 'JULIAN WILSON')
insert into tb_surfista values(12, 'KELLY SLATER')
insert into tb_surfista values(15, 'FILIPE TOLEDO')


create table tb_bateria (
   id_bateria int not null primary key identity(1,1),
   id_surfista_1 int not null,
   id_surfista_2 int not null
)

create table tb_ondas_bateria (
   id_onda int not null primary key identity(1,1),
   id_bateria int not null,
   id_surfista int not null,
   nota_1  numeric(10,2) check (nota_1 >=0 and nota_1 <=10),
   nota_2  numeric(10,2) check (nota_2 >=0 and nota_2 <=10),
   nota_3  numeric(10,2) check (nota_3 >=0 and nota_3 <=10),
   nota_4  numeric(10,2) check (nota_4 >=0 and nota_4 <=10)
)


create table tb_ondas_placar (
   id_bateria int not null,
   id_surfista int not null,
   nome_surfista varchar(100) not null,
   nota_final_onda1 numeric(10,2) null default(0.0),
   nota_final_onda2 numeric(10,2) null default(0.0),
   primary key (id_bateria, id_surfista)
)


-- Testes

insert into tb_bateria values (10,17)
SELECT * FROM tb_bateria


-- Primeira onda Gabriel
insert into tb_ondas_bateria(ID_BATERIA, ID_SURFISTA, NOTA_1, NOTA_2, NOTA_3, NOTA_4) values (4, 10, 9, 9.5, 9.3, 9.2)

-- Segunda onda Gabriel
insert into tb_ondas_bateria values (3, 10, 5, 5, 5, 5)

-- Terceira onda Gabriel
insert into tb_ondas_bateria values (3, 10, 10, 10, 10, 10)

-- Primeira Onda Julian
insert into tb_ondas_bateria values (1, 17, 8.7, 8, 8.3, 8.1)

-- Segunda Onda Julian
insert into tb_ondas_bateria values (1, 17, 9.4, 9, 9.1, 9.2)

-- Terceira Onda Julian
insert into tb_ondas_bateria values (1, 17, 10, 10, 10, 10)



--1
CREATE OR ALTER TRIGGER TG_INSERT_SURFISTA
ON tb_bateria
AFTER INSERT
AS
BEGIN
    DECLARE @ID_BATERIA INT;
    DECLARE @ID_SURFISTA1 INT;
    DECLARE @ID_SURFISTA2 INT;
    DECLARE @NOME_SURFISTA1 VARCHAR(100);
    DECLARE @NOME_SURFISTA2 VARCHAR(100);

    DECLARE C_SURFISTA CURSOR FOR
        SELECT id_bateria,id_surfista_1,id_surfista_2
        FROM inserted


    OPEN C_SURFISTA
    FETCH C_SURFISTA INTO @ID_BATERIA,@ID_SURFISTA1,@ID_SURFISTA2;
    WHILE(@@FETCH_STATUS = 0)
    BEGIN
        SET @NOME_SURFISTA1 = (SELECT nome_surfista FROM tb_surfista WHERE id_surfista = @ID_SURFISTA1);
        SET @NOME_SURFISTA2 = (SELECT nome_surfista FROM tb_surfista WHERE id_surfista = @ID_SURFISTA2);

        INSERT INTO tb_ondas_placar(ID_BATERIA, ID_SURFISTA, NOME_SURFISTA, NOTA_FINAL_ONDA1, NOTA_FINAL_ONDA2)
        VALUES
            (@ID_BATERIA,@ID_SURFISTA1,@NOME_SURFISTA1,0.0,0.0),
            (@ID_BATERIA,@ID_SURFISTA2,@NOME_SURFISTA2,0.0,0.0)
        FETCH C_SURFISTA INTO @ID_BATERIA,@ID_SURFISTA1,@ID_SURFISTA2;
    end
    CLOSE C_SURFISTA
    DEALLOCATE C_SURFISTA
end

SELECT * FROM tb_ondas_placar

--2
CREATE OR ALTER TRIGGER TG_REMOVER_PLACAR
ON tb_bateria
AFTER DELETE
AS
BEGIN
    DECLARE @ID_BATERIA INT;
    DECLARE C_BATERIA CURSOR FOR
        SELECT id_bateria
        FROM deleted;
    OPEN C_BATERIA
    FETCH C_BATERIA INTO @ID_BATERIA;
    WHILE (@@FETCH_STATUS = 0)
    BEGIN
        DELETE FROM tb_ondas_placar WHERE id_bateria = @id_bateria;
        FETCH C_BATERIA INTO @ID_BATERIA;
    END
    CLOSE C_BATERIA
    DEALLOCATE C_BATERIA
end

select * from tb_ondas_placar

delete from tb_bateria where id_bateria = 2;

--3
CREATE OR ALTER TRIGGER TG_ATUALIZAR_PLACAR
ON tb_ondas_bateria
AFTER INSERT
AS
BEGIN
    DECLARE @id_onda int;
    DECLARE @id_surfista int;
    DECLARE @nota_1  numeric(10,2);
    DECLARE @nota_2  numeric(10,2);
    DECLARE @nota_3  numeric(10,2);
    DECLARE @nota_4  numeric(10,2);
    DECLARE @MEDIA NUMERIC(10,2);
    DECLARE @NOTA_FINAL_1 NUMERIC(10,2);
    DECLARE @NOTA_FINAL_2 NUMERIC(10,2);

    DECLARE C_NOTAS_SURFISTA CURSOR FOR
        SELECT ID_ONDA,ID_SURFISTA,NOTA_1,NOTA_2,NOTA_3,NOTA_4
        FROM inserted;
    OPEN C_NOTAS_SURFISTA
    FETCH C_NOTAS_SURFISTA INTO @ID_ONDA,@ID_SURFISTA,@NOTA_1,@NOTA_2,@NOTA_3,@NOTA_4
    WHILE (@@FETCH_STATUS = 0)
    BEGIN
        SET @NOTA_FINAL_1 = ISNULL((SELECT nota_final_onda1 FROM tb_ondas_placar WHERE id_surfista = @ID_SURFISTA),0);
        SET @NOTA_FINAL_2 = ISNULL((SELECT nota_final_onda2 FROM tb_ondas_placar WHERE id_surfista = @ID_SURFISTA),0);
        SET @MEDIA = (@nota_1+@nota_2+@nota_3+@nota_4)/4.0
        IF @MEDIA > @NOTA_FINAL_1
        BEGIN
            UPDATE tb_ondas_placar
            SET nota_final_onda1 = @MEDIA
            WHERE id_surfista = @id_surfista
            IF @NOTA_FINAL_1 > @NOTA_FINAL_2
            BEGIN
                UPDATE tb_ondas_placar
                SET nota_final_onda2 = @NOTA_FINAL_1
                WHERE id_surfista = @id_surfista
            end
        end
        ELSE IF @MEDIA > @NOTA_FINAL_2
        BEGIN
            UPDATE tb_ondas_placar
            SET nota_final_onda2 = @MEDIA
            WHERE id_surfista = @id_surfista
        end
        FETCH C_NOTAS_SURFISTA INTO @ID_ONDA,@ID_SURFISTA,@NOTA_1,@NOTA_2,@NOTA_3,@NOTA_4
    END
    CLOSE C_NOTAS_SURFISTA
    DEALLOCATE C_NOTAS_SURFISTA
end