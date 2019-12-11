DROP TABLE IF EXISTS temp;

CREATE TABLE temp (
	idNF INTEGER UNSIGNED  NOT NULL  ,
	DataVenda DATE NOT NULL  ,
    ValorTotal FLOAT NOT NULL,
	NomeCliente CHAR(60)  NOT NULL,
    PRIMARY KEY(idNF));
    
CREATE OR REPLACE VIEW VW_AUX AS
	SELECT iv.NotaFiscal_idNF as idNF, DATE(nf.DataVenda) AS DataVenda, 
		SUM(iv.ValorTotal) AS ValorTotal, cl.nome AS NomeCliente
	FROM ItemVenda iv
	INNER JOIN NotaFiscal nf
		ON iv.NotaFiscal_idNF = nf.idNF
	INNER JOIN Cliente cl
		ON nf.Cliente_CpfCl = cl.CpfCl
	GROUP BY iv.NotaFiscal_idNF;

SELECT * FROM VW_AUX;

CALL ValorTotal(STR_TO_DATE("09/12/2019", "%d/%m/%Y" ),STR_TO_DATE("11/12/2019", "%d/%m/%Y" ));

SELECT * FROM NotaFiscal;

Select * from temp;