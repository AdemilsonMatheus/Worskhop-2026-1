-- ======================================================
-- 1. DEFINIÇÃO E CRIAÇÃO DO BANCO DE DADOS (DDL)
-- ======================================================
CREATE DATABASE IF NOT EXISTS VelozCar;
USE VelozCar;

-- Criação das Tabelas seguindo a lógica do modelo
CREATE TABLE IF NOT EXISTS Aluguel (
    ID_Aluguel INT PRIMARY KEY AUTO_INCREMENT,
    Data_Prevista_Retirada DATETIME,
    Status_Aluguel VARCHAR(30),
    Data_Aluguel DATETIME
);

CREATE TABLE IF NOT EXISTS Veiculos (
    ID_Veiculo INT PRIMARY KEY AUTO_INCREMENT,
    Placa VARCHAR(10) UNIQUE NOT NULL,
    Ano_Fabricacao INT,
    Cor VARCHAR(20),
    Modelo VARCHAR(50),
    Marca VARCHAR(50),
    Status VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Pagamentos (
    ID_Pagamento INT PRIMARY KEY AUTO_INCREMENT,
    Data_Vencimento DATE,
    Metodo VARCHAR(30),
    Valor_Total_Pago DECIMAL(10,2),
    Data_Pagamento DATETIME,
    Status VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Clientes (
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

CREATE TABLE IF NOT EXISTS Registro_aluguel (
    ID_Registro_Aluguel INT PRIMARY KEY AUTO_INCREMENT,
    Data_Inicio DATETIME,
    Status VARCHAR(20),
    Data_Devolucao_Real DATETIME,
    Valor_Total DECIMAL(10,2),
    fk_Veiculo_ID_Veiculo INT,
    FOREIGN KEY (fk_Veiculo_ID_Veiculo) REFERENCES Veiculos(ID_Veiculo)
);

CREATE TABLE IF NOT EXISTS Funcionarios (
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

CREATE TABLE IF NOT EXISTS Manutencao (
    ID_Manutencao INT PRIMARY KEY AUTO_INCREMENT,
    Custo_Total DECIMAL(10,2),
    Descricao_Problema TEXT,
    Data_Entrada DATE,
    Status_Servico VARCHAR(30),
    fk_Veiculo_ID_Veiculo INT,
    FOREIGN KEY (fk_Veiculo_ID_Veiculo) REFERENCES Veiculos(ID_Veiculo)
);

CREATE TABLE IF NOT EXISTS Escolhe (
    fk_Aluguel_ID_Aluguel INT,
    fk_Veiculo_ID_Veiculo INT,
    PRIMARY KEY (fk_Aluguel_ID_Aluguel, fk_Veiculo_ID_Veiculo),
    FOREIGN KEY (fk_Aluguel_ID_Aluguel) REFERENCES Aluguel(ID_Aluguel),
    FOREIGN KEY (fk_Veiculo_ID_Veiculo) REFERENCES Veiculos(ID_Veiculo)
);

-- ======================================================
-- 2. INSERÇÃO DE DADOS (DML) - 10 REGISTROS POR TABELA
-- ======================================================

INSERT IGNORE INTO Aluguel (ID_Aluguel, Status_Aluguel, Data_Aluguel) VALUES 
(1, 'Finalizado', '2026-03-01'), (2, 'Ativo', '2026-03-05'), (3, 'Ativo', '2026-03-10'), 
(4, 'Finalizado', '2026-03-12'), (5, 'Ativo', '2026-03-15'), (6, 'Cancelado', '2026-03-18'), 
(7, 'Ativo', '2026-03-19'), (8, 'Pendente', '2026-03-20'), (9, 'Ativo', '2026-03-20'), (10, 'Ativo', '2026-03-21');

INSERT IGNORE INTO Veiculos (ID_Veiculo, Placa, Ano_Fabricacao, Cor, Modelo, Marca, Status) VALUES 
(1, 'ABC1234', 2024, 'Branco', 'Onix', 'Chevrolet', 'Disponível'), (2, 'XYZ5678', 2023, 'Preto', 'Corolla', 'Toyota', 'Alugado'),
(3, 'KJH9988', 2024, 'Prata', 'HB20', 'Hyundai', 'Disponível'), (4, 'PLM0099', 2022, 'Azul', 'Compass', 'Jeep', 'Manutenção'),
(5, 'QWE1122', 2023, 'Vermelho', 'Mobi', 'Fiat', 'Disponível'), (6, 'RTY3344', 2024, 'Cinza', 'Civic', 'Honda', 'Alugado'),
(7, 'UIO5566', 2022, 'Branco', 'Argo', 'Fiat', 'Disponível'), (8, 'PAS7788', 2023, 'Preto', 'Hilux', 'Toyota', 'Disponível'),
(9, 'DFG9900', 2024, 'Azul', 'Nivus', 'VW', 'Manutenção'), (10, 'HJK1234', 2023, 'Prata', 'T-Cross', 'VW', 'Disponível');

INSERT IGNORE INTO Pagamentos (ID_Pagamento, Metodo, Valor_Total_Pago, Status) VALUES 
(1, 'PIX', 550.00, 'Concluído'), (2, 'Cartão', 1250.00, 'Concluído'), (3, 'Boleto', 400.00, 'Pendente'), 
(4, 'Cartão', 850.00, 'Concluído'), (5, 'PIX', 2100.00, 'Concluído'), (6, 'Boleto', 500.00, 'Pendente'), 
(7, 'Cartão', 350.00, 'Concluído'), (8, 'PIX', 800.00, 'Concluído'), (9, 'Boleto', 950.00, 'Pendente'), 
(10, 'Cartão', 200.00, 'Concluído');

INSERT IGNORE INTO Clientes (ID_Cliente, Nome, CPF, Numero_CNH, fk_Aluguel_ID_Aluguel, data_cadastro, Endereco) VALUES 
(1, 'João Silva', '12345678901', 'CNH111', 1, '2026-01-01', 'Centro'), (2, 'Maria Luz', '22345678902', 'CNH222', 2, '2026-01-05', 'Bairro A'),
(3, 'Carlos Vaz', '32345678903', 'CNH333', 3, '2026-01-10', 'Bairro B'), (4, 'Ana Rosa', '42345678904', 'CNH444', 4, '2026-01-12', 'Centro'),
(5, 'Pedro Gil', '52345678905', 'CNH555', 5, '2026-01-15', 'Bairro C'), (6, 'Rita Mota', '62345678906', 'CNH666', 6, '2026-01-18', 'Bairro A'),
(7, 'Luís Feio', '72345678907', 'CNH777', 7, '2026-01-20', 'Centro'), (8, 'Soraia Sá', '82345678908', 'CNH888', 8, '2026-01-22', 'Bairro B'),
(9, 'Nuno Paz', '92345678909', 'CNH999', 9, '2026-01-25', 'Bairro C'), (10, 'Bia Cruz', '02345678900', 'CNH000', 10, '2026-02-01', 'Centro');

INSERT IGNORE INTO Registro_aluguel (ID_Registro_Aluguel, Status, Valor_Total, fk_Veiculo_ID_Veiculo, Data_Inicio) VALUES 
(1, 'Finalizado', 550.00, 1, '2026-03-01'), (2, 'Finalizado', 1250.00, 2, '2026-03-05'), (3, 'Finalizado', 400.00, 3, '2026-03-10'), 
(4, 'Ativo', 850.00, 4, '2026-03-12'), (5, 'Ativo', 2100.00, 5, '2026-03-15'), (6, 'Finalizado', 500.00, 6, '2026-03-18'), 
(7, 'Ativo', 350.00, 7, '2026-03-19'), (8, 'Ativo', 800.00, 8, '2026-03-20'), (9, 'Finalizado', 950.00, 9, '2026-03-20'), (10, 'Ativo', 200.00, 10, '2026-03-21');

INSERT IGNORE INTO Funcionarios (ID_Funcionario, Matricula, CPF, Nome, fk_Registro_aluguel_ID_Registro_Aluguel, fk_Pagamento_ID_Pagamento, Cargo, Data_Adimissao) VALUES 
(1, 'M01', '111', 'Carlos', 1, 1, 'Atendente', '2025-01-01'), (2, 'M02', '222', 'Ana', 2, 2, 'Gerente', '2025-02-01'),
(3, 'M03', '333', 'Beto', 3, 3, 'Mecânico', '2025-03-01'), (4, 'M04', '444', 'Dora', 4, 4, 'Vendedor', '2025-04-01'),
(5, 'M05', '555', 'Edu', 5, 5, 'Atendente', '2025-05-01'), (6, 'M06', '666', 'Fia', 6, 6, 'Vendedor', '2025-06-01'),
(7, 'M07', '777', 'Gil', 7, 7, 'Gerente', '2025-07-01'), (8, 'M08', '888', 'Hia', 8, 8, 'Mecânico', '2025-08-01'),
(9, 'M09', '999', 'Ito', 9, 9, 'Vendedor', '2025-09-01'), (10, 'M10', '000', 'Jú', 10, 10, 'Atendente', '2025-10-01');

INSERT IGNORE INTO Manutencao (ID_Manutencao, Custo_Total, Status_Servico, fk_Veiculo_ID_Veiculo, Descricao_Problema) VALUES 
(1, 150.00, 'Concluído', 1, 'Filtros'), (2, 300.00, 'Pendente', 4, 'Pneus'), (3, 500.00, 'Concluído', 9, 'Motor'), 
(4, 200.00, 'Concluído', 4, 'Freios'), (5, 100.00, 'Pendente', 1, 'Óleo'), (6, 50.00, 'Concluído', 1, 'Lâmpada'), 
(7, 120.00, 'Pendente', 9, 'Alinhamento'), (8, 80.00, 'Concluído', 4, 'Balanceamento'), (9, 300.00, 'Concluído', 1, 'Revisão'), 
(10, 250.00, 'Pendente', 9, 'Suspensão');

INSERT IGNORE INTO Escolhe (fk_Aluguel_ID_Aluguel, fk_Veiculo_ID_Veiculo) VALUES 
(1,1), (2,2), (3,3), (4,4), (5,5), (6,6), (7,7), (8,8), (9,9), (10,10);

-- 2.3 ATUALIZAÇÕES (UPDATE) - Uso da PK para evitar erro 1175
UPDATE Veiculos SET Status = 'Disponível' WHERE ID_Veiculo > 0 AND Placa = 'XYZ5678';
UPDATE Registro_aluguel SET Valor_Total = Valor_Total * 1.05 WHERE ID_Registro_Aluguel > 0 AND Status = 'Ativo';

-- ======================================================
USE VelozCar;

-- ======================================================
-- 3.1. CONSULTAS DE AGREGAÇÃO E AGRUPAMENTO 
-- ======================================================

-- 1. Faturamento Total por Método de Pagamento (Financeiro)
SELECT Metodo, SUM(Valor_Total_Pago) AS Receita_Total, COUNT(*) AS Qtd_Transacoes 
FROM Pagamentos 
GROUP BY Metodo;

-- 2. Quantidade de Veículos por Marca (Estoque/Frota)
SELECT Marca, COUNT(*) AS Total_Veiculos 
FROM Veiculos 
GROUP BY Marca;

-- 3. Status de Aluguéis Processados (Operacional)
SELECT Status_Aluguel, COUNT(*) AS Qtd_Alugueis 
FROM Aluguel 
GROUP BY Status_Aluguel;

-- 4. Gasto Acumulado com Oficina por Veículo (Manutenção)
SELECT fk_Veiculo_ID_Veiculo AS ID_Carro, SUM(Custo_Total) AS Total_Gasto 
FROM Manutencao 
GROUP BY fk_Veiculo_ID_Veiculo;

-- 5. Distribuição de Funcionários por Cargo (RH)
SELECT Cargo, COUNT(*) AS Total_Equipe 
FROM Funcionarios 
GROUP BY Cargo;

-- ======================================================
-- 3.2. OPERAÇÕES DE JOIN 
-- ======================================================

-- 6. Relatório Principal: Cliente, Carro Escolhido e Status (INNER JOIN)
SELECT C.Nome AS Cliente, V.Modelo AS Carro, A.Status_Aluguel AS Status_Reserva
FROM Clientes C
INNER JOIN Aluguel A ON C.fk_Aluguel_ID_Aluguel = A.ID_Aluguel
INNER JOIN Escolhe E ON A.ID_Aluguel = E.fk_Aluguel_ID_Aluguel
INNER JOIN Veiculos V ON E.fk_Veiculo_ID_Veiculo = V.ID_Veiculo;

-- 7. Auditoria Financeira: Funcionário, Cargo, Valor e Método (INNER JOIN)
SELECT F.Nome AS Funcionario, F.Cargo, P.Valor_Total_Pago, P.Metodo
FROM Funcionarios F
INNER JOIN Pagamentos P ON F.fk_Pagamento_ID_Pagamento = P.ID_Pagamento;

-- 8. Histórico Técnico: Modelo, Placa e Custos de Manutenção (INNER JOIN)
SELECT V.Modelo, V.Placa, M.Custo_Total, M.Status_Servico
FROM Veiculos V
INNER JOIN Manutencao M ON V.ID_Veiculo = M.fk_Veiculo_ID_Veiculo;