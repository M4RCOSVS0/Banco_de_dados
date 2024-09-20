USE CURSORES02;

CREATE TABLE TB_FUNCIONARIO (
  MATRICULA INT NOT NULL PRIMARY KEY,
  NOME VARCHAR(50) NOT NULL
) 

CREATE TABLE TB_DEPENDENTES (
  ID_DEPENDENTE INT NOT NULL IDENTITY(1,1),
  MATRICULA INT NOT NULL REFERENCES TB_FUNCIONARIO(MATRICULA),
  NOME VARCHAR(50) NOT NULL
  PRIMARY KEY (ID_DEPENDENTE, MATRICULA)
)

INSERT INTO TB_FUNCIONARIO VALUES (1, 'JOS� RICARDO')
INSERT INTO TB_FUNCIONARIO VALUES (2, 'ANA MILLER')

INSERT INTO TB_DEPENDENTES VALUES (1, 'ROBERTA'),
                                  (1, 'RITA'),
				  (1, 'GABRIELA')

INSERT INTO TB_DEPENDENTES VALUES (2, 'GUSTAVO'),
                                   (2, 'MARIANA')

DECLARE @Matricula INT, @NomeFuncionario NVARCHAR(100)
DECLARE @NomeDependente NVARCHAR(100)

-- Cursor para Funcionários
DECLARE Funcionario_Cursor CURSOR FOR
SELECT Matricula, Nome
FROM TB_FUNCIONARIO
ORDER BY Matricula

-- Cursor para Dependentes
DECLARE Dependente_Cursor CURSOR FOR
SELECT Nome
FROM TB_DEPENDENTE
WHERE MatriculaFuncionario = @Matricula
ORDER BY Nome

-- Abrindo o cursor de Funcionários
OPEN Funcionario_Cursor
FETCH NEXT FROM Funcionario_Cursor INTO @Matricula, @NomeFuncionario

PRINT 'FUNCIONARIOS E DEPENDENTES'
PRINT 'MATRICULA    NOME                NOME DEPENDENTE'
PRINT '------------------------------------------------------------'

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Exibindo informações do funcionário
    PRINT @Matricula + '    ' + @NomeFuncionario
    PRINT '------------------------------------------------------------'
    
    -- Abrindo o cursor de Dependentes
    OPEN Dependente_Cursor
    
    FETCH NEXT FROM Dependente_Cursor INTO @NomeDependente
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Exibindo os dependentes
        PRINT '                  ' + @NomeDependente
        FETCH NEXT FROM Dependente_Cursor INTO @NomeDependente
    END
    
    -- Fechando o cursor de Dependentes
    CLOSE Dependente_Cursor
    
    PRINT '------------------------------------------------------------'
    
    -- Buscando o próximo funcionário
    FETCH NEXT FROM Funcionario_Cursor INTO @Matricula, @NomeFuncionario
END

-- Fechando o cursor de Funcionários
CLOSE Funcionario_Cursor
DEALLOCATE Funcionario_Cursor
DEALLOCATE Dependente_Cursor
                                   