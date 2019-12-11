## PRIMEIROS OS PRINCIPAIS SELECTS ##

# LEGENDA
# MC = Medicamento Controlado
# NF = Nota Fiscal

## Quais os itens de características especiais (remédios controlados)?

SELECT md.Medicamento_idMED, m.nome
FROM MedControlado md
INNER JOIN Medicamento m
ON m.idMed = md.Medicamento_idMed;

# Apenas comparando os id de todos os medicamentos presentes na tabela Medicamento com os da tabela MedControlado
# Conseguimos separar todos que são MC e então exibir seus IDs e Nomes atraves da tabela Medicamento
# SELECT * FROM MedControlado;
# SELECT * FROM Medicamento;


## Quais clientes já compraram remédios controlados e os respectivos funcionários que efetuaram a venda?

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

# Camila é a unica Funcionaria que é Farmacêutica, portanto apenas ela pode vender MC
# Os medicamentos controlados são de id = 6,7 e 9
# Olhando as venda é possivel ver que todas as compras de MC foram feitas pelo mesmo cliente
# SELECT * FROM itemvenda ORDER BY medicamento_idmed ASC;
# Olhando a NF do pedido, vemos que a Nota da compra dos MC foi da Cliente de CPF = 208412, Marina Silva.
# SELECT * FROM NotaFiscal;


#Quais clientes com sobrenome ‘Silva’ realizaram compras com valores maiores que R$ 100?

SELECT c.Nome#, SUM(iv.ValorTotal) AS "Valor Total"
FROM NotaFiscal nf
INNER JOIN ItemVenda iv
ON nf.idNF = iv.NotaFiscal_idNF
INNER JOIN Cliente c
ON nf.Cliente_CpfCl = c.CpfCl 
WHERE c.Nome LIKE '%Silva' 
AND iv.ValorTotal > 100
GROUP BY c.Nome;

# Atraves da NF, fazemos uma junção com a tabela de vendas para ter acesso aos valores das vendas
# em seguidas fazemos outra junção, com a tabela de cliente, para ter acesso aos nomes
# e então filtramos para todos com o determinado nome quais dele fizeram compras com valores acima do determinado e então exibimos
# o nome do cliente, adicionamente é posivel ver qual o valor total da compra do cliente 
# apenas fazendo uma soma dos valores de todos os iten comprados pelo menos na mesma NF
# SELECT * FROM ItemVenda;


##Mostre, para cada venda, quantos dias já se passaram, qual funcionário e máquina registradora da venda.

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

# Novamente fazendo algumas junções atarves da NF temos como saber que funcionario fez cada venda e o dia em que ela foi feita
# feito isso basta fazer a diferença da data atual para a data da compra.
# SELECT * FROM NotaFiscal;

## DELETES E UPDATES ##

##Remover itens com preço unitário abaixo de R$ 2,00

# Exibir tabela antes das alterações
SELECT * FROM Medicamento
ORDER BY ValorUni;

# Deletar os Medicamentos com valor unitario menos que R$ 2,00
DELETE FROM Medicamento 
WHERE ValorUni < 2;

# Mostrar novamente a tabela, demonstrando as alterações
SELECT * FROM Medicamento
ORDER BY ValorUni;

## Para os itens com preço unitário entre R$ 15 e R$ 30, aumentar em 15% o seu valor

# Exibir tabela antes das alterações
SELECT * FROM Medicamento
ORDER BY ValorUni;

# Atualiza o valor unitario dos medicamentos com ValorUni entre R$ 15 e R$ 30
UPDATE Medicamento
SET ValorUni = (ValorUni + 15/100*ValorUni)
WHERE ValorUni BETWEEN 15 AND 30;

# Adicionalmente Atualiza o valor final do produto para corresponder com a atulização anterior.
# UPDATE Medicamento
# SET ValorFinal = (ValorFinal + 15/100*ValorFinal)
# WHERE ValorFinal BETWEEN 150 AND 300;

# Mostrar novamente a tabela, demonstrando as alterações
SELECT * FROM Medicamento
ORDER BY ValorUni;