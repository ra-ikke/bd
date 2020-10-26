DELIMITER $
CREATE DEFINER=`root`@`localhost` TRIGGER `ControleDeEstoque` AFTER INSERT ON `itemvenda` FOR EACH ROW BEGIN
	#Declarando variaveis que serão usadadas pra comparação
    
    DECLARE EstoqueMinimo INTEGER;
    DECLARE EstoquePosVenda INTEGER;
    DECLARE QtdComprada INTEGER;
 
    #Preenchendo as variaveis com buscas 
    
    SELECT me.QuantMin
    FROM MedEstoque me
	WHERE NEW.Medicamento_idMed = me.Medicamento_idMed INTO EstoqueMinimo;
    
    SELECT iv.Quantidade
    FROM ItemVenda iv
    WHERE NEW.idItemVenda = iv.idItemVenda INTO QtdComprada;
    
    ## Atualizando o estoque apos a compra do item
    
    UPDATE MedEstoque
    SET Quantidade = (Quantidade - QtdComprada)
    WHERE NEW.Medicamento_idMed = Medicamento_idMed;
    
    ## Preenchendo a variavel depois da atualização
    
    SELECT me.Quantidade
    FROM MedEstoque me
	WHERE NEW.Medicamento_idMed = me.Medicamento_idMed INTO EstoquePosVenda;

    
    ## Verificando se o estoque atual esta dentro do limite minimo
    
    IF (EstoquePosVenda <= EstoqueMinimo)
    THEN 
		## Caso o estoque seja igual ou superior ao limite, informa ao usuario
		SIGNAL SQLSTATE '55000'
				SET MESSAGE_TEXT = 'Estoque mínimo foi atingido!';
	END IF;
END
$
