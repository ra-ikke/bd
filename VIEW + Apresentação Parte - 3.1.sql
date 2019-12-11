#Criar uma visão para mostrar o nome do medicamento e preço unitário, nome fornecedor, do mais barato ao mais caro
CREATE OR REPLACE VIEW VW_Med_Forn_Preco AS
	SELECT 
	med.Nome AS MedNome,
	med.ValorUni AS ValorUni,
	forn.Nome AS FornNome
    FROM Medicamento med
	INNER JOIN Fornecedor forn
		ON med.Fornecedor_Cnpj = forn.Cnpj
    ORDER BY med.ValorUni ASC;

#Em seguida, mostre o comando para executar a visão criada, apresentando todos os seus atribuww
SELECT MedNome, ValorUni, FornNome FROM VW_Med_Forn_Preco;

#Com base na view criada em 2.1, exibir nome do medicamento e preço unitário, e a média de preço unitário do acervo
SELECT MedNome, AVG(ValorUni) as MediaPreço, FornNome FROM VW_Med_Forn_Preco;