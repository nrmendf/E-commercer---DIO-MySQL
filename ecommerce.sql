CREATE DATABASE ecommerce;
USE ecommerce;

-- Tabela de Clientes (Pessoa Física e Jurídica)
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    cnpj VARCHAR(18) UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(20)
);

-- Tabela de Endereços
CREATE TABLE enderecos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    rua VARCHAR(100),
    numero VARCHAR(10),
    cidade VARCHAR(50),
    estado VARCHAR(50),
    cep VARCHAR(15),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Tabela de Fornecedores
CREATE TABLE fornecedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL
);

-- Tabela de Categorias de Produtos
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- Tabela de Produtos
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL,
    categoria_id INT,
    fornecedor_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id),
    FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(id)
);

-- Tabela de Pedidos
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Em processamento',
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Tabela de Itens do Pedido
CREATE TABLE itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- Tabela de Pagamentos
CREATE TABLE pagamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    tipo_pagamento VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pendente',
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id)
);

-- Tabela de Entregas
CREATE TABLE entregas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    codigo_rastreio VARCHAR(50),
    status VARCHAR(50) DEFAULT 'Aguardando envio',
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id)
);


-- Inserindo clientes
INSERT INTO clientes (nome, cpf, email, telefone) VALUES 
('João Silva', '123.456.789-00', 'joao@email.com', '11999998888'),
('Empresa XYZ', NULL, 'contato@xyz.com.br', '1133334444');

-- Inserindo endereços
INSERT INTO enderecos (cliente_id, rua, numero, cidade, estado, cep) VALUES
(1, 'Rua das Flores', '123', 'São Paulo', 'SP', '01000-000');

-- Inserindo fornecedores
INSERT INTO fornecedores (nome, cnpj) VALUES 
('Fornecedor A', '11.222.333/0001-44'),
('Fornecedor B', '44.555.666/0001-77');

-- Inserindo categorias
INSERT INTO categorias (nome) VALUES ('Eletrônicos'), ('Roupas');

-- Inserindo produtos
INSERT INTO produtos (nome, descricao, preco, estoque, categoria_id, fornecedor_id) VALUES 
('Notebook', 'Notebook com 16GB RAM', 3500.00, 10, 1, 1),
('Camiseta', 'Camiseta 100% algodão', 50.00, 100, 2, 2);

-- Inserindo pedidos
INSERT INTO pedidos (cliente_id) VALUES (1);

-- Inserindo itens no pedido
INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES 
(1, 1, 1, 3500.00),
(1, 2, 2, 50.00);

-- Inserindo pagamentos
INSERT INTO pagamentos (pedido_id, tipo_pagamento, status) VALUES 
(1, 'Cartão de Crédito', 'Aprovado');

-- Inserindo entregas
INSERT INTO entregas (pedido_id, codigo_rastreio, status) VALUES 
(1, 'BR123456789', 'Enviado');


SELECT c.nome, COUNT(p.id) AS total_pedidos 
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.nome;


SELECT c.nome 
FROM clientes c
INNER JOIN fornecedores f ON c.cnpj = f.cnpj;


SELECT p.nome AS produto, f.nome AS fornecedor, p.estoque
FROM produtos p
JOIN fornecedores f ON p.fornecedor_id = f.id;


SELECT f.nome AS fornecedor, p.nome AS produto
FROM fornecedores f
JOIN produtos p ON f.id = p.fornecedor_id;


SELECT p.id AS pedido_id, c.nome AS cliente, 
       SUM(i.quantidade * i.preco_unitario) AS total_pedido
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.id
JOIN itens_pedido i ON p.id = i.pedido_id
GROUP BY p.id, c.nome;


SELECT p.id AS pedido_id, c.nome AS cliente, pg.status 
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.id
JOIN pagamentos pg ON p.id = pg.pedido_id
WHERE pg.status = 'Aprovado';


SELECT p.id AS pedido_id, c.nome AS cliente, 
       SUM(i.quantidade * i.preco_unitario) AS total_pedido
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.id
JOIN itens_pedido i ON p.id = i.pedido_id
GROUP BY p.id, c.nome
HAVING total_pedido > 1000;


