--executando fun��es

-- Fun��es escalares (fun��es que retornam um valor)
SELECT DBO.[ufnLeadingZeros](123)


-- TVF (Table Valued Functions: Fun��es com valores em tabela)
SELECT * 
FROM [dbo].[ufnGetContactInformation](93)

