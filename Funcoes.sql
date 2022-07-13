--executando funções

-- Funções escalares (funções que retornam um valor)
SELECT DBO.[ufnLeadingZeros](123)


-- TVF (Table Valued Functions: Funções com valores em tabela)
SELECT * 
FROM [dbo].[ufnGetContactInformation](93)

