CREATE DATABASE Farmacia;
USE Farmacia;

CREATE TABLE Funcionario (
  CpfFun INTEGER UNSIGNED  NOT NULL  ,
  Nome CHAR(60)  NOT NULL  ,
  Ende CHAR(60)  NOT NULL  ,
  DataNas DATE  NOT NULL  ,
  Sexo CHAR  NOT NULL    ,
PRIMARY KEY(CpfFun));


CREATE TABLE MaquinaReg (
  SerialNum INTEGER UNSIGNED  NOT NULL  ,
  DataCompra DATE  NOT NULL    ,
PRIMARY KEY(SerialNum));


CREATE TABLE Fornecedor (
  Cnpj INTEGER UNSIGNED  NOT NULL  ,
  Nome CHAR(60)  NOT NULL  ,
  Ende CHAR(60)  NOT NULL    ,
PRIMARY KEY(Cnpj));


CREATE TABLE Cliente (
  CpfCl INTEGER UNSIGNED  NOT NULL  ,
  Nome CHAR(60)  NOT NULL  ,
  Ende CHAR(60)  NOT NULL  ,
  DataNas DATE  NOT NULL  ,
  Sexo CHAR  NOT NULL    ,
PRIMARY KEY(CpfCl));


CREATE TABLE Farmaceutico (
  Crf INTEGER UNSIGNED  NOT NULL  ,
  Funcionario_CpfFun INTEGER UNSIGNED  NOT NULL    ,
PRIMARY KEY(Crf),
  CONSTRAINT FK_FAR_FUN FOREIGN KEY(Funcionario_CpfFun)
    REFERENCES Funcionario(CpfFun));


CREATE TABLE Medicamento (
  idMed INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  Fornecedor_Cnpj INTEGER UNSIGNED  NOT NULL  ,
  Nome CHAR(60)  NOT NULL  ,
  Descricao CHAR(60)  NOT NULL  ,
  ValorUni FLOAT(10,2)  NOT NULL  ,
  ValorFinal FLOAT(10,2)  NOT NULL    ,
PRIMARY KEY(idMed),
  CONSTRAINT FK_M_FOR FOREIGN KEY(Fornecedor_Cnpj)
    REFERENCES Fornecedor(Cnpj));


CREATE TABLE NotaFiscal (
  idNF INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  MaquinaReg_SerialNum INTEGER UNSIGNED  NOT NULL  ,
  Funcionario_CpfFun INTEGER UNSIGNED  NOT NULL  ,
  Cliente_CpfCl INTEGER UNSIGNED  NOT NULL  ,
  DataVenda DATE  NOT NULL    ,
PRIMARY KEY(idNF),
  CONSTRAINT FK_NF_CL FOREIGN KEY(Cliente_CpfCl)
    REFERENCES Cliente(CpfCl),
  CONSTRAINT FK_NF_F FOREIGN KEY(Funcionario_CpfFun)
    REFERENCES Funcionario(CpfFun),
  CONSTRAINT FK_NF_MR FOREIGN KEY(MaquinaReg_SerialNum)
    REFERENCES MaquinaReg(SerialNum));


CREATE TABLE MedControlado (
  Receita INTEGER UNSIGNED  NOT NULL  ,
  Medicamento_idMed INTEGER UNSIGNED  NOT NULL    ,
PRIMARY KEY(Receita),
  CONSTRAINT FK_MC_M FOREIGN KEY(Medicamento_idMed)
    REFERENCES Medicamento(idMed)
    ON DELETE CASCADE);


CREATE TABLE MedEstoque (
  idItem INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  Medicamento_idMed INTEGER UNSIGNED  NOT NULL  ,
  Quantidade INTEGER UNSIGNED  NOT NULL  ,
  QuantMin INTEGER UNSIGNED  NOT NULL    ,
PRIMARY KEY(idItem),
  CONSTRAINT FK_ME_M FOREIGN KEY(Medicamento_idMed)
    REFERENCES Medicamento(idMed)
    ON DELETE CASCADE);


CREATE TABLE ItemVenda (
  idItemVenda INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  NotaFiscal_idNF INTEGER UNSIGNED  NOT NULL  ,
  Medicamento_idMed INTEGER UNSIGNED  NOT NULL  ,
  Quantidade INTEGER UNSIGNED  NOT NULL  ,
  ValorTotal FLOAT(10,2)  NOT NULL    ,
PRIMARY KEY(idItemVenda),
  CONSTRAINT FK_IV_M FOREIGN KEY(Medicamento_idMed)
    REFERENCES Medicamento(idMed)
    ON DELETE CASCADE,
  CONSTRAINT FK_IV_NF FOREIGN KEY(NotaFiscal_idNF)
    REFERENCES NotaFiscal(idNF));


CREATE TABLE LOGMCONTROLADO (
  idLog INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  DataLog DATE  NOT NULL  ,
  HoraLog TIME  NOT NULL  ,
  MedControlado_Receita INTEGER UNSIGNED  NOT NULL  ,
  Farmaceutico_Crf INTEGER UNSIGNED  NOT NULL    ,
PRIMARY KEY(idLog),
  CONSTRAINT FK_LGMC_FARM FOREIGN KEY(Farmaceutico_Crf)
    REFERENCES Farmaceutico(Crf),
  CONSTRAINT FK_LGMC_MC FOREIGN KEY(MedControlado_Receita)
    REFERENCES MedControlado(Receita));

CREATE TABLE LOGNF (
  idLogNf INTEGER UNSIGNED  NOT NULL   AUTO_INCREMENT,
  NotaFiscal_idNF INTEGER UNSIGNED  NOT NULL  ,
  Medicamento_idMed INTEGER UNSIGNED  NOT NULL    ,
PRIMARY KEY(idLogNf),
  FOREIGN KEY(NotaFiscal_idNF)
    REFERENCES NotaFiscal(idNF),
  FOREIGN KEY(Medicamento_idMed)
    REFERENCES Medicamento(idMed)
    ON DELETE CASCADE);

CREATE TABLE Verificar (
	idTabela INTEGER NOT NULL AUTO_INCREMENT,
	idItem INTEGER NOT NULL,
	PRIMARY KEY (idTabela)
);