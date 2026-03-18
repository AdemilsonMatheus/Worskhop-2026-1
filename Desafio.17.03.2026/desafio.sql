CREATE SCHEMA DESAFIO;

CREATE TABLE DESAFIO.Clientes (
    ID_Cliente SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(150) UNIQUE,
    Data_Cadastro DATE NOT NULL,
    Cidade VARCHAR(50)
);

CREATE TABLE DESAFIO.Pedidos (
    ID_Pedido SERIAL PRIMARY KEY,
    Data_Pedido TIMESTAMP NOT NULL,
    Valor_Total DECIMAL(10, 2) NOT NULL,
    Status VARCHAR(20) DEFAULT 'Pendente',
    ID_Cliente_FK INTEGER NOT NULL,
    CONSTRAINT FK_Cliente_Pedido FOREIGN KEY (ID_Cliente_FK) 
    REFERENCES DESAFIO.Clientes(ID_Cliente)
);

INSERT INTO DESAFIO.Clientes (Nome, Email, Data_Cadastro, Cidade) VALUES
('João Silva', 'joao@email.com', '2023-01-15', 'São Paulo'),
('Maria Souza', 'maria@email.com', '2023-02-10', 'Rio de Janeiro'),
('Pedro Santos', 'pedro@email.com', '2023-03-05', 'Belo Horizonte'),
('Ana Costa', 'ana@email.com', '2023-03-22', 'São Paulo'),
('Lucas Pereira', 'lucas@email.com', '2023-04-12', 'Porto Alegre'),
('Carla Dias', 'carla@email.com', '2023-04-20', 'Curitiba'),
('Marcos Rocha', 'marcos@email.com', '2023-05-01', 'São Paulo'),
('Juliana Lima', 'juliana@email.com', '2023-05-18', 'Salvador'),
('Roberto Nunes', 'roberto@email.com', '2023-06-02', 'Belo Horizonte'),
('Fernanda Alves', 'fernanda@email.com', '2023-06-15', 'Recife');

INSERT INTO DESAFIO.Pedidos (Data_Pedido, Valor_Total, Status, ID_Cliente_FK) VALUES
('2023-02-01 10:30:00', 150.50, 'Enviado', 1),
('2023-02-15 14:00:00', 320.00, 'Entregue', 1),
('2023-03-10 16:45:00', 89.90,  'Entregue', 2),
('2023-03-20 09:15:00', 450.00, 'Pendente', 3),
('2023-04-05 11:00:00', 1200.00,'Entregue', 4),
('2023-04-18 13:30:00', 215.75, 'Enviado', 5),
('2023-05-05 17:00:00', 75.00,  'Pendente', 6),
('2023-05-10 08:30:00', 510.20, 'Entregue', 7),
('2023-06-01 12:00:00', 300.00, 'Enviado', 1),
('2023-06-20 15:30:00', 950.00, 'Pendente', 8);

UPDATE DESAFIO.Pedidos SET Status = 'Entregue' WHERE ID_Pedido = 4;

SELECT Nome, Email, Cidade FROM DESAFIO.Clientes WHERE Cidade = 'São Paulo';

SELECT COUNT(*) FROM DESAFIO.Pedidos;
SELECT SUM(Valor_Total) FROM DESAFIO.Pedidos;
SELECT AVG(Valor_Total) FROM DESAFIO.Pedidos;

SELECT Cidade, COUNT(ID_Cliente) FROM DESAFIO.Clientes GROUP BY Cidade;
SELECT Status, SUM(Valor_Total) FROM DESAFIO.Pedidos GROUP BY Status;

SELECT P.ID_Pedido, C.Nome 
FROM DESAFIO.Pedidos P 
INNER JOIN DESAFIO.Clientes C ON P.ID_Cliente_FK = C.ID_Cliente;