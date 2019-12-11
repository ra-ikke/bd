DELIMITER $
CREATE DEFINER=`root`@`localhost` TRIGGER `LogControlado` BEFORE INSERT ON `itemvenda` FOR EACH ROW BEGIN
	#Declarando variaveis que serão usadadas pra comparação
	DECLARE CpfFun INTEGER; 
	DECLARE idMed INTEGER;
	DECLARE Crf INTEGER;
    DECLARE Receita INTEGER;
	
	#Preenchendo as variaveis com buscas 
    SELECT mc.Receita
    FROM MedControlado mc
	WHERE NEW.Medicamento_IdMed = mc.Medicamento_IdMed INTO Receita;
    
    SELECT nf.Funcionario_CpfFun 
    FROM NotaFiscal nf 
    WHERE NEW.NotaFiscal_idNF = nf.idNF INTO CpfFun;
    
	SELECT mc.Medicamento_idMed 
    FROM MedControlado mc 
    WHERE mc.Medicamento_idMed = NEW.Medicamento_idMed INTO idMed;
    
    SELECT far.Crf 
    FROM Farmaceutico far 
    WHERE far.Funcionario_CpfFun = CpfFun INTO Crf;
	
    #Se idMed é null, significa que o medicamento não é controlado.
    IF idMed IS NOT NULL
    THEN
		#Se CRF é null, significa que o funcionario não é um farmaco, então ele não poderá vender o remédio controlado.
		IF Crf IS NOT NULL
		THEN
			INSERT INTO LogMControlado VALUES
				(NULL, CURDATE(), CURTIME(),Receita,Crf);
        ELSE
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Funcionário não é Farmacêutico!';
        END IF;
    END IF;
END
$