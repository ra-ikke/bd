DELIMITER $

CREATE PROCEDURE Inserir_Fornecedor (Cnpj INTEGER, Nome CHAR(60), Ende CHAR(60))
BEGIN 

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		ROLLBACK;
		SELECT CONCAT('Fornecedor ja cadastrado - Cnpj:', Cnpj) as MensagemErro;
	END;
	START TRANSACTION;
	INSERT INTO Fornecedor VALUES (Cnpj, Nome, Ende);
	COMMIT;
	SELECT ('Fornecedor incluido.');
    
END;
$

CREATE PROCEDURE Deletar_Fornecedor (Cnpj INTEGER)

BEGIN 

	DECLARE EXIT HANDLER FOR 1176
	BEGIN
		ROLLBACK;
		SELECT ('Fornecedor não existe.') as MensagemErro;
	END;
	START TRANSACTION;
	DELETE FROM Fornecedor WHERE Cnpj = Fornecedor.Cnpj;
	COMMIT;
	SELECT ('Fornecedor deletado.');
    
END;
$

CREATE PROCEDURE Inserir_Medicamento (Fornecedor_Cnpj INTEGER, Nome CHAR(60), Descricao CHAR(60),  ValorUni DOUBLE, ValorFinal DOUBLE)

BEGIN 

	DECLARE EXIT HANDLER FOR 1062
	BEGIN
		ROLLBACK;
		SELECT ('Medicamento ja cadastrado.') as MensagemErro;
	END;
	START TRANSACTION;
	INSERT INTO Medicamento VALUES (NULL, Fornecedor_Cnpj, Nome, Descricao, ValorUni, ValorFinal);
	COMMIT;
	SELECT ('Medicamento incluido.') AS "Relatório";
    
END;
$

CREATE PROCEDURE Deletar_Medicamento (Nome CHAR(60))

BEGIN 

	DECLARE EXIT HANDLER FOR 1176
	BEGIN
		ROLLBACK;
		SELECT ('Medicamento não existe.') as MensagemErro;
	END;
	START TRANSACTION;
	DELETE FROM Medicamento 
    WHERE Nome = Medicamento.Nome;
	COMMIT;
	SELECT ('Medicamento deletado.') AS "Relatório";
    
END;
$

CREATE PROCEDURE Emitir_NF (NF INTEGER, idItem1 INTEGER, idItem2 INTEGER, idItem3 INTEGER, idItem4 INTEGER, idItem5 INTEGER)

BEGIN 
    
    ## Declara variavel para verificar se o IdMed passado pelo paramentro realmente existe no banco de remedios
	DECLARE idExiste1 INTEGER;
    DECLARE idExiste2 INTEGER;
    DECLARE idExiste3 INTEGER;
    DECLARE idExiste4 INTEGER;
    DECLARE idExiste5 INTEGER;
    
    #Se o IdMed passado não for de um remedio no banco, encerra a operação
    DECLARE CONTINUE HANDLER FOR 1452
	BEGIN
		ROLLBACK;
		SELECT ('O Valor de NF inserido não corresponde a nenhum dos valores do banco !') AS MensagemErro;
	END;
    
	IF idItem1 IS NOT NULL
    THEN
		## Verifica se o IdMed Existe no banco de remedios
		SELECT idMed
		FROM medicamento
		WHERE idMed = idItem1 INTO idExiste1;
        
        ## Se o IdMed passado não for de um remedio no banco, ativa o EXIT HANDLER, se existir, inserir no LOG nomalmente
		IF idExiste1 IS NOT NULL
        THEN
			START TRANSACTION;
			INSERT INTO LOGNF VALUES ( NULL, NF, idItem1);
            INSERT INTO Verificar VALUES (NULL, idItem1);
            COMMIT;
		END IF;
	END IF;

	IF idItem2 IS NOT NULL
    THEN
		## Verifica se o IdMed Existe no banco de remedios
		SELECT idMed
		FROM medicamento
		WHERE idMed = idItem2 INTO idExiste2;
        
        ## Se o IdMed passado não for de um remedio no banco, ativa o EXIT HANDLER, inserir no LOG nomalmente
		IF idExiste2 IS NOT NULL
        THEN
			START TRANSACTION;
			INSERT INTO LOGNF VALUES ( NULL, NF, idItem2);
            INSERT INTO Verificar VALUES (NULL, idItem2);
            COMMIT;
		END IF;
	END IF;
    
	IF idItem3 IS NOT NULL
    THEN
		## Verifica se o IdMed Existe no banco de remedios
		SELECT idMed
		FROM medicamento
		WHERE idMed = idItem3 INTO idExiste3;
        
        ## Se o IdMed passado não for de um remedio no banco, ativa o EXIT HANDLER, inserir no LOG nomalmente
		IF idExiste3 IS NOT NULL
        THEN
			START TRANSACTION;
			INSERT INTO LOGNF VALUES ( NULL, NF, idItem3);
            INSERT INTO Verificar VALUES (NULL, idItem3);
            COMMIT;
		END IF;
	END IF;
    
	IF idItem4 IS NOT NULL
    THEN
		## Verifica se o IdMed Existe no banco de remedios
		SELECT idMed
		FROM medicamento
		WHERE idMed = idItem4 INTO idExiste4;
        
        ## Se o IdMed passado não for de um remedio no banco, ativa o EXIT HANDLER, inserir no LOG nomalmente
		IF idExiste4 IS NOT NULL
        THEN
			START TRANSACTION;
			INSERT INTO LOGNF VALUES ( NULL, NF, idItem4);
            INSERT INTO Verificar VALUES (NULL, idItem4);
            COMMIT;
		END IF;
	END IF;
    
	IF idItem5 IS NOT NULL
    THEN
		## Verifica se o IdMed Existe no banco de remedios
		SELECT idMed
		FROM medicamento
		WHERE idMed = idItem5 INTO idExiste5;
        
        ## Se o IdMed passado não for de um remedio no banco, ativa o EXIT HANDLER, se existir, inserir no LOG nomalmente
		IF idExiste5 IS NOT NULL
        THEN
			START TRANSACTION;
			INSERT INTO LOGNF VALUES ( NULL, NF, idItem5);
            INSERT INTO Verificar VALUES (NULL, idItem5);
            COMMIT;
		END IF;
	END IF;
	SELECT v.idItem AS "id Incluidos", m.Nome
    FROM Verificar v
    JOIN medicamento m
    ON v.idItem = m.idMed;
    DELETE FROM Verificar;
    
END;
$

DELIMITER ;