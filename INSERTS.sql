#Inserção de Cliente
#(CpfCl,Nome,Ende,DataNas,Sexo)

INSERT INTO Cliente VALUES
	(967004,'Raique Carvalho','Rua das Arvores',STR_TO_DATE( "11/01/1997", "%d/%m/%Y" ),'M');

INSERT INTO Cliente VALUES
	(753541,'Jamile Souza','Avenida das Flores',STR_TO_DATE( "31/01/1997", "%d/%m/%Y" ),'F');
    
INSERT INTO Cliente VALUES
	(456465,'João Silva','Rua 23 de Agosto',STR_TO_DATE( "15/10/1992", "%d/%m/%Y" ),'M');

INSERT INTO Cliente VALUES
	(208412,'Marina Silva','Travessa dos Colibris',STR_TO_DATE( "28/04/1976", "%d/%m/%Y" ),'F');
    
#-------------------------------------------------------------------------------------------- 

#Inserção de Funcionario
#(CpfFun,Nome,Ende,DataNas,Sexo)

INSERT INTO Funcionario VALUES
	(156154,'Marcos Silva','Travessa dos Matos',STR_TO_DATE("23/02/2000", "%d/%m/%Y" ),'M');
    
INSERT INTO Funcionario VALUES
	(319234,'Camila Oliveira','Avenida Manuela',STR_TO_DATE("15/08/1995", "%d/%m/%Y" ),'F');

#--------------------------------------------------------------------------------------------

#Inserção de Farmaceutico
#(Crf,Funcionario_CpfFun)

INSERT INTO Farmaceutico VALUES
	(02251,319234);

#--------------------------------------------------------------------------------------------

#Inserção de Maquina Registradora
#(SerialNum,DataCompra)

INSERT INTO MaquinaReg VALUES
	(12315,STR_TO_DATE("23/08/2010", "%d/%m/%Y" ));

INSERT INTO MaquinaReg VALUES
	(23184,STR_TO_DATE("06/04/2014", "%d/%m/%Y" ));

INSERT INTO MaquinaReg VALUES
	(45451,STR_TO_DATE("11/11/2019", "%d/%m/%Y" ));
    
#--------------------------------------------------------------------------------------------

#Inserção de Fornecedores
#(Cnpj,Nome,Ende)

INSERT INTO Fornecedor VALUES
	(415646,"Sanofi Medley Farmacêutica Ltda","Av. das Nações Unidas");
    
INSERT INTO Fornecedor VALUES
	(156412,"EMS Medicamentos","Rod. Jornalista Francisco Aguirre Proença");

#--------------------------------------------------------------------------------------------

#Inserção de Medicamentos
#(idMed,Fornecedor_Cnpj,Nome,Descricao,ValorUni,ValorFinal)

INSERT INTO Medicamento VALUES
	(null,415646,"Prednisona","Venda sob prescrição médica",123.6,1236);
    
INSERT INTO Medicamento VALUES
	(null,415646,"Tylenol","Venda sob prescrição médica",3.35,33);

INSERT INTO Medicamento VALUES
	(null,415646,"Maleato de Enalapril","Venda sob prescrição médica",6.00,60);

INSERT INTO Medicamento VALUES
	(null,156412,"Benegripe","Venda sob prescrição médica",28.9,289);
    
INSERT INTO Medicamento VALUES
	(null,156412,"Parecetamol","Venda sob prescrição médica",7.2,72);

INSERT INTO Medicamento VALUES
	(null,415646,"Alprazolam","Remedio Controlado",1.4,14);
    
INSERT INTO Medicamento VALUES
	(null,415646,"Diazepam","Remedio Controlado",41.2,412);
    
INSERT INTO Medicamento VALUES
	(null,156412,"Anador","Venda sob prescrição médica",1.6,16);
    
INSERT INTO Medicamento VALUES
	(null,415646,"Lorenin","Remedio Controlado",4.8,48);
    
#--------------------------------------------------------------------------------------------

#Inserção de Medicamentos Controlados
#(Receita,Medicamento_idMed)

INSERT INTO MedControlado VALUES
	(7451,6);

INSERT INTO MedControlado VALUES
	(9865,7);
    
INSERT INTO MedControlado VALUES
	(2684,9);

#--------------------------------------------------------------------------------------------

#Inserção de NotasFiscais
#(idNF,MaquinaReg_SerialNum,Funcionario_CpfFun,Cliente_CpfCl,DataVenda)

INSERT INTO NotaFiscal VALUES
	(null,12315,156154,967004,curdate());

INSERT INTO NotaFiscal VALUES
	(null,45451,319234,208412,curdate());

INSERT INTO NotaFiscal VALUES
	(null,12315,156154,456465,curdate());
    
INSERT INTO NotaFiscal VALUES
	(12345,45451,319234,753541,curdate());
    
#STR_TO_DATE("11/09/2020", "%d/%m/%Y" )
#--------------------------------------------------------------------------------------------

#Inserção de ItemVenda
#(idItemVenda,NotaFiscal_idNF,Medicamento_idMed,Quantidade,ValorTotal)

SELECT * FROM ItemVenda;
SELECT * FROM LogMControlado;
SELECT * FROM MedEstoque;

INSERT INTO ItemVenda VALUES
	(null,1,2,5,(SELECT ValorFinal FROM Medicamento WHERE idMed = 2)*5);

INSERT INTO ItemVenda VALUES
	(null,2,1,2,(SELECT ValorFinal FROM Medicamento WHERE idMed = 1)*2);

INSERT INTO ItemVenda VALUES
	(null,3,3,4,(SELECT ValorFinal FROM Medicamento WHERE idMed = 3)*4);

INSERT INTO ItemVenda VALUES
	(null,12345,4,7,(SELECT ValorFinal FROM Medicamento WHERE idMed = 4)*7);

INSERT INTO ItemVenda VALUES
	(null,1,5,9,(SELECT ValorFinal FROM Medicamento WHERE idMed = 5)*9);

INSERT INTO ItemVenda VALUES
	(null,2,6,1,(SELECT ValorFinal FROM Medicamento WHERE idMed = 6));
    
INSERT INTO ItemVenda VALUES
	(null,2,7,4,(SELECT ValorFinal FROM Medicamento WHERE idMed = 7)*4);

#--------------------------------------------------------------------------------------------

#Inserção de MedEstoque
#(idItem,Medicamento_idMed,Quantidade, QuantMin)

INSERT INTO MedEstoque VALUES
	(null,1,300,30);	

INSERT INTO MedEstoque VALUES
	(null,2,170,55);	

INSERT INTO MedEstoque VALUES
	(null,3,90,30);	

INSERT INTO MedEstoque VALUES
	(null,4,130,40);	

INSERT INTO MedEstoque VALUES
	(null,5,150,50);	
    
INSERT INTO MedEstoque VALUES
	(null,6,50,20);	
    
INSERT INTO MedEstoque VALUES
	(null,7,60,20);	
    
INSERT INTO MedEstoque VALUES
	(null,8,120,40);	
    
INSERT INTO MedEstoque VALUES
	(null,9,40,20);	

