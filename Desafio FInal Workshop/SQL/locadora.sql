-- ======================================================
-- 1. DEFINIÇÃO E CRIAÇÃO DO BANCO DE DADOS (DDL)
-- ======================================================
CREATE DATABASE IF NOT EXISTS VelozCar;
USE VelozCar;

-- Limpeza para permitir re-execução sem erros
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS Escolhe, Manutencao, Funcionarios, Registro_aluguel, Clientes, Pagamentos, Veiculos, Aluguel;
SET FOREIGN_KEY_CHECKS = 1;

-- Criação das Tabelas
CREATE TABLE Aluguel (
    ID_Aluguel INT PRIMARY KEY AUTO_INCREMENT,
    Data_Prevista_Retirada DATETIME,
    Status_Aluguel VARCHAR(30),
    Data_Aluguel DATETIME
);

CREATE TABLE Veiculos (
    ID_Veiculo INT PRIMARY KEY AUTO_INCREMENT,
    Placa VARCHAR(10) UNIQUE NOT NULL,
    Ano_Fabricacao INT,
    Cor VARCHAR(20),
    Modelo VARCHAR(50),
    Marca VARCHAR(50),
    Status VARCHAR(20)
);

CREATE TABLE Pagamentos (
    ID_Pagamento INT PRIMARY KEY AUTO_INCREMENT,
    Data_Vencimento DATE,
    Metodo VARCHAR(30),
    Valor_Total_Pago DECIMAL(10,2),
    Data_Pagamento DATETIME,
    Status VARCHAR(50)
);

CREATE TABLE Clientes (
    ID_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) NOT NULL,
    CPF CHAR(11) UNIQUE NOT NULL,
    Email VARCHAR(255),
    Endereco VARCHAR(150),
    Telefone VARCHAR(100),
    data_cadastro DATE,
    Numero_CNH VARCHAR(20) UNIQUE NOT NULL,
    fk_Aluguel_ID_Aluguel INT,
    FOREIGN KEY (fk_Aluguel_ID_Aluguel) REFERENCES Aluguel(ID_Aluguel)
);

CREATE TABLE Registro_aluguel (
    ID_Registro_Aluguel INT PRIMARY KEY AUTO_INCREMENT,
    Data_Inicio DATETIME,
    Status VARCHAR(20),
    Data_Devolucao_Real DATETIME,
    Valor_Total DECIMAL(10,2),
    fk_Veiculo_ID_Veiculo INT,
    FOREIGN KEY (fk_Veiculo_ID_Veiculo) REFERENCES Veiculos(ID_Veiculo)
);

CREATE TABLE Funcionarios (
    ID_Funcionario INT PRIMARY KEY AUTO_INCREMENT,
    Login_Sistema VARCHAR(50),
    Matricula VARCHAR(20) UNIQUE NOT NULL,
    CPF CHAR(11) UNIQUE NOT NULL,
    Data_Adimissao DATE,
    Nome VARCHAR(100),
    Cargo VARCHAR(50),
    Senha_Hash VARCHAR(50),
    fk_Registro_aluguel_ID_Registro_Aluguel INT,
    fk_Pagamento_ID_Pagamento INT,
    FOREIGN KEY (fk_Registro_aluguel_ID_Registro_Aluguel) REFERENCES Registro_aluguel(ID_Registro_Aluguel),
    FOREIGN KEY (fk_Pagamento_ID_Pagamento) REFERENCES Pagamentos(ID_Pagamento)
);

CREATE TABLE Manutencao (
    ID_Manutencao INT PRIMARY KEY AUTO_INCREMENT,
    Custo_Total DECIMAL(10,2),
    Descricao_Problema TEXT,
    Data_Entrada DATE,
    Status_Servico VARCHAR(30),
    fk_Veiculo_ID_Veiculo INT,
    FOREIGN KEY (fk_Veiculo_ID_Veiculo) REFERENCES Veiculos(ID_Veiculo)
);

CREATE TABLE Escolhe (
    fk_Aluguel_ID_Aluguel INT,
    fk_Veiculo_ID_Veiculo INT,
    PRIMARY KEY (fk_Aluguel_ID_Aluguel, fk_Veiculo_ID_Veiculo),
    FOREIGN KEY (fk_Aluguel_ID_Aluguel) REFERENCES Aluguel(ID_Aluguel),
    FOREIGN KEY (fk_Veiculo_ID_Veiculo) REFERENCES Veiculos(ID_Veiculo)
);

-- ======================================================
-- 2. INSERÇÃO E MANIPULAÇÃO DE DADOS (DML)
-- ======================================================

-- Populando Aluguel
INSERT INTO Aluguel (Data_Prevista_Retirada, Status_Aluguel, Data_Aluguel) VALUES 
('2026-03-01 10:00:00', 'Finalizado', '2026-03-01'), ('2026-03-05 09:00:00', 'Ativo', '2026-03-05'),
('2026-03-10 14:00:00', 'Ativo', '2026-03-10'), ('2026-03-12 08:30:00', 'Finalizado', '2026-03-12'),
('2026-03-15 11:00:00', 'Ativo', '2026-03-15'), ('2026-03-18 16:00:00', 'Cancelado', '2026-03-18'),
('2026-03-19 10:00:00', 'Ativo', '2026-03-19'), ('2026-03-20 09:00:00', 'Pendente', '2026-03-20'),
('2026-03-20 15:00:00', 'Ativo', '2026-03-20'), ('2026-03-21 08:00:00', 'Ativo', '2026-03-21');

-- Populando Veiculos
INSERT INTO Veiculos (Placa, Ano_Fabricacao, Cor, Modelo, Marca, Status) VALUES 
('ABC1234', 2024, 'Branco', 'Onix', 'Chevrolet', 'Disponível'), ('XYZ5678', 2023, 'Preto', 'Corolla', 'Toyota', 'Alugado'),
('KJH9988', 2024, 'Prata', 'HB20', 'Hyundai', 'Disponível'), ('PLM0099', 2022, 'Azul', 'Compass', 'Jeep', 'Manutenção'),
('QWE1122', 2023, 'Vermelho', 'Mobi', 'Fiat', 'Disponível'), ('RTY3344', 2024, 'Cinza', 'Civic', 'Honda', 'Alugado'),
('UIO5566', 2022, 'Branco', 'Argo', 'Fiat', 'Disponível'), ('PAS7788', 2023, 'Preto', 'Hilux', 'Toyota', 'Disponível'),
('DFG9900', 2024, 'Azul', 'Nivus', 'VW', 'Manutenção'), ('HJK1234', 2023, 'Prata', 'T-Cross', 'VW', 'Disponível');

-- Populando Registro_aluguel
INSERT INTO Registro_aluguel (Data_Inicio, Status, Valor_Total, fk_Veiculo_ID_Veiculo) VALUES 
('2026-03-01', 'Finalizado', 500.00, 1), ('2026-03-05', 'Finalizado', 1200.00, 2),
('2026-03-10', 'Finalizado', 350.00, 3), ('2026-03-12', 'Ativo', 800.00, 4),
('2026-03-15', 'Ativo', 2000.00, 5), ('2026-03-18', 'Finalizado', 450.00, 6),
('2026-03-19', 'Ativo', 300.00, 7), ('2026-03-20', 'Ativo', 750.00, 8),
('2026-03-20', 'Finalizado', 900.00, 9), ('2026-03-21', 'Ativo', 150.00, 10);

-- Populando Outras Tabelas
INSERT INTO Clientes (Nome, CPF, Numero_CNH, fk_Aluguel_ID_Aluguel) VALUES ('João Silva', '12345678901', 'CNH111', 1);
INSERT INTO Pagamentos (Metodo, Valor_Total_Pago, Status) VALUES ('PIX', 500.00, 'Concluído');
INSERT INTO Funcionarios (Matricula, CPF, Nome, fk_Registro_aluguel_ID_Registro_Aluguel, fk_Pagamento_ID_Pagamento) VALUES ('M01', '11111111111', 'Carlos', 1, 1);

-- 2.3 Atualizações (UPDATE) SEM desativar Safe Mode
-- Usamos ID > 0 para satisfazer a exigência de chave no WHERE
UPDATE Veiculos SET Status = 'Disponível' WHERE ID_Veiculo > 0 AND Placa = 'PLM0099';
UPDATE Registro_aluguel SET Valor_Total = Valor_Total * 1.05 WHERE ID_Registro_Aluguel > 0 AND Status = 'Ativo';

-- ======================================================
-- 3. CONSULTAS E ANÁLISES (DQL)
-- ======================================================

-- Agregações
SELECT Metodo, SUM(Valor_Total_Pago) AS Faturamento FROM Pagamentos GROUP BY Metodo;

-- JOINs
SELECT C.Nome, A.Status_Aluguel, A.Data_Aluguel
FROM Clientes C
INNER JOIN Aluguel A ON C.fk_Aluguel_ID_Aluguel = A.ID_Aluguel;

SELECT V.Modelo, V.Placa, R.Valor_Total, R.Status
FROM Veiculos V
INNER JOIN Registro_aluguel R ON V.ID_Veiculo = R.fk_Veiculo_ID_Veiculo;