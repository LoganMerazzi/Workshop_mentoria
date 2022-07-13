/*
INSTALAÇÃO DO SQL SERVER

Executável
  - https://www.microsoft.com/pt-br/sql-server/sql-server-downloads
    - Baixar a versão Developer
    - E a Express?

Docker

Baixar uma base de exemplo. Recomendações:
  - Adventure Works
    - https://docs.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=tsql
  - World Wide Importers
    - https://docs.microsoft.com/en-us/sql/samples/wide-world-importers-oltp-install-configure?view=sql-server-ver16

*/

/*
Ferramenta para conectar no SQL Server:
  - SSMS
  - Azure Data Studio
  - DBEaver
  - ...

Modelo do SQL Server:
Instância (Instalação)
  Database
    Schema
	  Tabelas


*/

/*

SINTAXES

CREATE DATABASE [NomeDoBanco]

USE NomeDoBanco

CREATE TABLE [schema].NomeDaTabela (
    NomeDaColuna1 TipoDaColuna1 'opções'
  , NomeDaColuna2 TipoDaColuna2 'opções'
  , NomeDaColuna3 TipoDaColuna3 'opções'
  [...]
)

INSERT INTO NomeDaTabela [(NomeDaColuna1, NomeDaColuna2, ...)]
VALUES
(ValorDaColuna1, ValorDaColuna2, ...)

SELECT NomeDaColuna1, NomeDaColuna2, ... [*]
FROM NomeDaTabela
WHERE 
  NomeDaColunaX = 'ValorPesquisado'
[group by ColunaY]
[HAVING funcao condicional valor]
[order by ColunaS]

UPDATE NomeDaTabela
SET 
  ColunaX = 'NovoValor1'
  [,ColunaY = 'NovoValor2' ]
where
  [ColunaZ = 'XXX' ]


DELETE FROM NomeDaTabela
[WHERE ColunaX = 'ValorParaSerApagado']

TRUNCATE TABLE NomeDaTabela
*/


-- consultas simples

SELECT 'Oi mundo' AS Ola

-- Selecionando toda as colunas de uma tabela
SELECT * FROM [Sales].[Store]

SELECT * FROM [Sales].[Currency]

-- Selecionando algumas colunas apenas
SELECT 
 p.ProductID, p.Name
FROM [Production].[Product] p

-- Selecionando os valores distintos de uma coluna
select DISTINCT CardType
from [Sales].[CreditCard]


-- Filtrando uma tabela: A clásula WHERE
select * 
from [Sales].[CreditCard]
where CardNumber = '77777688940363' 

-- filtrando pelo começo de um texto
select *
from [Production].[Product]
where Name like 'Flat Washer%'


-- filtrando pelo final de um texto
select *
from [Production].[Product]
where Name like '%1'

-- filtrando por qualquer posição de um texto
select *
from [Production].[Product]
where Name like '%1000%'

-- Funções do SQL

-- contando os registros de uma tabela
select count(*)
from [Sales].[SalesOrderHeader]

-- Agrupando as linhas por alguma coluna
select orderDate as data_do_pedido, count(*) as total_de_pedidos
from [Sales].[SalesOrderHeader]
group by orderDate
order by orderDate desc --total_de_pedidos desc

-- buscando o máximo e o mínimo
select 
    max(totalDue) as maior_pedido
  , min(totalDue) as menor_pedido
  , avg(totalDue) as media_pedido
  , sum(totalDue) as total_pedido
from [Sales].[SalesOrderHeader]

-- Média de compras por data
select 
    orderDate as data_do_pedido
  , max(totalDue) Valor_Maximo
  , min(totalDue) Valor_Minimo
  , avg(TotalDue) as valor_Medio
from [Sales].[SalesOrderHeader]
group by orderDate
order by orderDate

-- Exemplo com subquery
select *
from [Sales].[SalesOrderHeader]
where TotalDue = (
  select max(totalDue)
  from [Sales].[SalesOrderHeader]
)

-- Selecionar o TOP X registros mais caros
-- with ties 
select TOP 1 /*with ties*/ *  
from [Production].[Product]
order by ListPrice desc

-- Retornando produtos sem ordem de compra:
select *
from 
  [Sales].[SalesOrderHeader] soh
where PurchaseOrderNumber is null


-- Juntar duas ou mais tabelas
select *
from 
  [Sales].[SalesOrderHeader] soh
join [Sales].[SalesOrderDetail] sod
on soh.SalesOrderID = sod.SalesOrderID



select Pers.FirstName, pers.LastName, STATUS,
     CASE STATUS 
	   WHEN 1 THEN 'In process'
	   WHEN 2 THEN 'Approved'
	   WHEN 3 THEN 'Backordered' 
	   WHEN 4 THEN 'Rejected'
	   WHEN 5 THEN 'Shipped'
	   WHEN 6 THEN 'Cancelled'
	END AS STATUS_EXPLICADO
from 
  [Sales].[SalesOrderHeader] soh
join [Sales].[Customer] cust
on soh.CustomerID = cust.CustomerID
join [Person].[Person] pers
on cust.PersonID = pers.BusinessEntityID
where pers.FirstName = 'Gustavo' --and pers.LastName = 'Achong'



-- VIEWS
-- Abrir uma view no banco e ver o conteúdo

SELECT * FROM [HumanResources].[vEmployee]

-- PROCEDURES
-- Abrir uma procedure no banco e ver o conteúdo

-- Functions
-- Abrir uma function no banco e ver o conteúdo