create database MeusLivros
GO
use MeusLivros
GO
create table Livros (
  cod int, 
  autores varchar(200), 
  titulo varchar(100), 
  Assuntos varchar(50), 
  Editora varchar(50), 
  Cidade_Editora varchar(50), 
  Ano_publicacao smallint
)

go

insert into Livros 
values
(1, 'Assis', 'ABCDE', 'Romance; Texto Errado', 'Nova', 'São Paulo', 1980),
(2, 'Carlos; Rafael', 'XPTO', 'Filosofia', 'Arco', 'Salvador', 2020)

GO

select * from Livros

GO

UPDATE Livros
SET Assuntos = 'Romance; Ficção'
WHERE COD = 1

GO

select * from Livros

GO

sp_rename 'dbo.Livros', 'Livros_old'

GO

CREATE TABLE Livros (
  codLivro int, 
  titulo varchar(100), 
  Ano_publicacao smallint,
  Cod_Editora int
)

CREATE TABLE Editoras(
  codEditora int, 
  Nome varchar(100), 
  Cidade varchar(100)
)

GO

-- Vamos inserir os Livros e as editoras
INSERT INTO Livros 
values
(1, 'ABCDE', 1980, ?? ), -- Eu não tenho editora inserida, devo inserir elas primeiro
(2, 'XPTO', 2020, ??)

GO

INSERT INTO Editoras
VALUES 
  (100, 'Nova', 'São Paulo'),
  (200, 'Arco', 'Salvador'),
  (300, 'Brasport', 'Porto Alegre')
GO

INSERT INTO Livros 
values
(1, 'ABCDE', 1980, 100), 
(2, 'XPTO', 2020, 200)


INSERT INTO Livros 
values
(3, 'SQL', 2022, 500)

GO

select * from Livros
select * from Editoras

-- INNER JOIN
select *
from Livros as L
join Editoras as E
on 
  L.Cod_Editora = E.codEditora

-- OUTER JOINS -> LEFT JOIN / RIGHT JOIN / FULL JOIN
select *
from Livros as L
FULL OUTER join Editoras as E
on 
  L.Cod_Editora= E.codEditora

-- Garantir que o livro sempre tenha uma editora vinculada: not null
ALTER TABLE Livros ALTER COLUMN Cod_Editora int NOT NULL

INSERT INTO Livros (codLivro, titulo, Ano_publicacao)
values
(3, 'SQL', 2022)

-- Para ver as propriedades de uma tabela
exec SP_HELP 'Livros'
-- (ou, pode usar o atalho ALT+F1, selecionando a tabela)

-- Apagar as tabelas
drop table Livros
drop table Editoras


-- Simulando o uso do NOLOCK
begin tran

update Livros 
set [Ano_publicacao] = 200

select * from Livros

-- Abrir uma outra janela e executar apenas os 2 selects abaixo

select * from livros --> Deve ficar trancada a consulta... Cancele

select * from livros with (nolock) --> vai retornar os dados atualizados, mas podem ser dados errados. Quer ver?

-- Execute um rollback e execute novamente a query acima. Os dados voltaram para o estado anterior.
rollback
commit



