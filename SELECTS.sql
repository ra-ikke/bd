#Qual a descrição do item (medicamento) de maior valor (preço unitário) na farmácia?"

SELECT nome,descricao 
FROM Medicamento 
WHERE ValorUni = (SELECT MAX(ValorUni) 
				  FROM Medicamento);

SELECT * FROM MEDICAMENTO;


#Qual a Data da Venda (Nota Fiscal) de número 12345?"

SELECT DISTINCT (DataVenda)
FROM NotaFiscal 
WHERE idNF = 12345;

SELECT * FROM NotaFiscal;

#Mostre o código do item, sua descrição e a expressão ‘item caro’ se o preço unitário for maior que R$ 1000;
#ou a expressão ‘item de preço moderado’ se o preço for entre R$ 100 e R$ 999; ou ainda a expressão ‘item barato’
#se o preço for menor que R$ 100."

SELECT idMed, Descricao, 'Item Caro' AS Expressao 
FROM Medicamento 
where ValorFinal >= 1000 
UNION 
SELECT idMed, Descricao, 'Item de Preço Moderado' AS Expressao 
FROM Medicamento 
WHERE ValorFinal BETWEEN 100 and 999
UNION 
SELECT idMed, Descricao, 'Item Barato' AS Expressao 
FROM Medicamento 
WHERE ValorFinal < 100;

SELECT * FROM Medicamento;


#Mostre o número da nota e quantidade de itens vendidos em ordem ascendente do número da nota."

SELECT NotaFiscal_idNF AS Nota_Fiscal, SUM(Quantidade) AS Quantidade_Itens 
FROM ItemVenda 
GROUP BY NotaFiscal_idNF
ORDER BY NotaFiscal_idNF ASC;

SELECT * FROM itemvenda;


#Mostre o número da nota e quantos tipos de itens vendidos, em ordem decrescente do número da nota
#(se vendeu Anador e Tylenol, são dois tipos. Não é a quantidade de Anador ou Tylenol vendida)"

SELECT NotaFiscal_idNF AS Nota_Fiscal, count(DISTINCT Medicamento_idMed) AS Quantidade_Tipos 
FROM ItemVenda iv
GROUP BY NotaFiscal_idNF 
ORDER BY NotaFiscal_idNF DESC;

SELECT * FROM itemvenda;

#Qual o valor total da venda da nota fiscal 12345?

SELECT SUM(ValorTotal) AS Valor_Total 
FROM ItemVenda 
WHERE NotaFiscal_idNF = 12345;

SELECT * FROM itemvenda;


#Qual a média de preço dos itens cujo valor é menor que R$ 50?

SELECT AVG(ValorFinal) AS Media_Preco 
FROM Medicamento 
WHERE ValorFinal < 50.00;

SELECT * FROM Medicamento;


#Quais os preços unitários existentes?  E quais os diferentes tipos de preços existentes? 
#Pergunta Ruim

SELECT ValorUni, ValorFinal 
FROM Medicamento
GROUP BY ValorUni;


#Quais os preços unitários com valores iguais que estão presentes em mais de 2 itens?

SELECT ValorUni 
FROM Medicamento 
WHERE (SELECT COUNT(ValorUni) 
	   FROM Medicamento) > 2
GROUP BY ValorUni
ORDER BY ValorUni ASC;

#Quais os itens de características especiais (remédios controlados)?

SELECT md.Medicamento_idMED, m.nome
FROM MedControlado md
INNER JOIN Medicamento m
ON m.idMed = md.Medicamento_idMed;

SELECT * FROM MedControlado;

#Quais clientes já compraram remédios controlados e os respectivos funcionários que efetuaram a venda?

SELECT c.Nome AS "Nome Cliente", f.Nome AS "Nome Funcionário", mc.Medicamento_idMed
FROM NotaFiscal nf
INNER JOIN Cliente c
ON nf.Cliente_cpfCl = c.cpfCl
INNER JOIN Funcionario f
ON nf.Funcionario_cpfFun = f.cpfFun
INNER JOIN ItemVenda iv
ON nf.idNF = iv.Notafiscal_idNF
INNER JOIN Medicamento m
ON iv.Medicamento_idMed = m.idMed
INNER JOIN MedControlado mc
ON m.idMed = mc.Medicamento_idMed;

#sla como prova

#Quais clientes com sobrenome ‘Silva’ realizaram compras com valores maiores que R$ 100?

SELECT c.Nome
FROM NotaFiscal nf
INNER JOIN ItemVenda iv
ON nf.idNF = iv.NotaFiscal_idNF
INNER JOIN Cliente c
ON nf.Cliente_CpfCl = c.CpfCl 
WHERE c.Nome LIKE '%Silva' 
AND iv.ValorTotal > 100
GROUP BY c.Nome;

SELECT * FROM ItemVenda;

#Mostre, para cada venda, quantos dias já se passaram, qual funcionário e máquina registradora da venda.

SELECT iv.idItemVenda, (CurDate() - nf.DataVenda) AS "Tempo pós venda", f.Nome AS "Funcionário", mr.SerialNum AS "Maquina Registradora"
FROM NotaFiscal nf
INNER JOIN ItemVenda iv
ON iv.NotaFiscal_idNF = nf.idNF
INNER JOIN Funcionario f
ON f.cpfFun = nf.Funcionario_cpfFun
INNER JOIN MaquinaReg mr
ON mr.SerialNum = nf.MaquinaReg_SerialNum
GROUP BY iv.idItemVenda
ORDER BY iv.idItemVenda;


#Com base na questão anterior, mostre o número da nota fiscal cuja data de venda foi a mais recentemente realizada.

SELECT idNF, DataVenda
FROM NotaFiscal
WHERE DataVenda = (SELECT MAX(DataVenda)
				   FROM NotaFiscal);
                   
