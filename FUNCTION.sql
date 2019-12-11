DELIMITER $
CREATE DEFINER=`root`@`localhost` PROCEDURE `valorTotal`(Data_inicial DATE, Data_final DATE)
BEGIN
    DECLARE Aux_nfs INT;
    
    DECLARE Max_idade INT;
    DECLARE totalVendas FLOAT;
    
    DECLARE Qtd INT;
    
    DECLARE NF INTEGER;
    DECLARE DT_Venda DATE;
    DECLARE Valor_Total FLOAT;
    DECLARE Nome_Cliente CHAR(60);
    DECLARE Idade_Cliente INT;
    
    DECLARE DT_VendaAtual DATE;
    
    DECLARE fimlista integer default 0;
	
	DECLARE FNF CURSOR FOR
		SELECT idNF FROM NotaFiscal;
    
    DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET fimlista = 1;
    
    SELECT year(curdate())-min(year(DataNas)) FROM cliente into Max_idade;
    
    SELECT Count(*) FROM NotaFiscal INTO Qtd;
    
    OPEN FNF;
    lerLista:  LOOP
		IF Qtd = 0 THEN 
			LEAVE lerLista;
		END IF;	
        FETCH FNF INTO Aux_nfs;
            SELECT DataVenda FROM VW_AUX WHERE idNF = Aux_nfs INTO DT_VendaAtual;
			IF DT_VendaAtual BETWEEN Data_Inicial and Data_final	THEN
				SELECT idNF FROM VW_AUX WHERE idNF = Aux_nfs INTO NF;
				SELECT DataVenda FROM VW_AUX WHERE idNF = Aux_nfs INTO DT_Venda;
				SELECT ValorTotal FROM VW_AUX WHERE idNF = Aux_nfs INTO Valor_Total;
				SELECT NomeCliente FROM VW_AUX WHERE idNF = Aux_nfs INTO Nome_Cliente;
                
                SELECT year(curdate())-year(cl.DataNas)
                FROM Cliente cl
                INNER JOIN NotaFiscal nf
					ON cl.CpfCl = nf.Cliente_Cpfcl
				WHERE nf.idNF = Aux_nfs
				INTO Idade_Cliente;
                
                # SELECT NF, DT_Venda, Valor_Total, Nome_Cliente, Idade_Cliente;
                IF Idade_Cliente NOT LIKE Max_idade THEN
					INSERT INTO temp VALUES (NF,DT_Venda,Valor_Total,Nome_Cliente);
				END IF;
                SET Qtd = Qtd - 1;
			END IF;
    END LOOP;
    CLOSE FNF;
    
    select idNF,DataVenda,ValorTotal,NomeCliente from temp ORDER BY idNF;
    
    DROP VIEW VW_AUX;
    DROP TABLE temp;
END
$