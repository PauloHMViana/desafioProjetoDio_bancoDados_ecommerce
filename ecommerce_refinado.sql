CREATE DATABASE ecommerce_refinado;
USE ecommerce_refinado;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(20),
    tipo_cliente ENUM('PF','PJ') NOT NULL
);

CREATE TABLE cliente_pf (
    id_cliente INT PRIMARY KEY,
    cpf VARCHAR(14) UNIQUE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE cliente_pj (
    id_cliente INT PRIMARY KEY,
    cnpj VARCHAR(18) UNIQUE,
    razao_social VARCHAR(150),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

INSERT INTO clientes (nome, email, telefone, tipo_cliente) VALUES
('João Silva', 'joao@email.com', '11999999999', 'PF'),
('Empresa XYZ', 'contato@xyz.com', '1133333333', 'PJ'),
('Maria Oliveira', 'maria@email.com', '11988888888', 'PF');

INSERT INTO cliente_pf VALUES (1, '111.222.333-44');
INSERT INTO cliente_pj VALUES (2, '22.333.444/0001-55', 'Empresa XYZ Ltda');
INSERT INTO cliente_pf VALUES (3, '555.666.777-88');

CREATE TABLE enderecos (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    rua VARCHAR(100),
    cidade VARCHAR(50),
    estado VARCHAR(2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

INSERT INTO enderecos (id_cliente, rua, cidade, estado) VALUES
(1, 'Rua A', 'São Paulo', 'SP'),
(2, 'Rua B', 'Rio de Janeiro', 'RJ'),
(3, 'Rua C', 'Belo Horizonte', 'MG');

CREATE TABLE pessoas (
    id_pessoa INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    tipo ENUM('Fornecedor','Vendedor','Ambos') NOT NULL
);

INSERT INTO pessoas (nome, tipo) VALUES
('Carlos Souza', 'Fornecedor'),
('Ana Lima', 'Vendedor'),
('João Pereira', 'Ambos');

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(50)
);

INSERT INTO categorias (nome_categoria) VALUES
('Eletrônicos'),
('Roupas'),
('Livros');

CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(100),
    preco DECIMAL(10,2),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

INSERT INTO produtos (nome_produto, preco, id_categoria) VALUES
('Smartphone', 1500.00, 1),
('Camiseta Polo', 80.00, 2),
('Livro SQL Básico', 45.00, 3);

CREATE TABLE estoques (
    id_estoque INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT,
    id_fornecedor INT,
    quantidade INT,
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_fornecedor) REFERENCES pessoas(id_pessoa)
);

INSERT INTO estoques (id_produto, id_fornecedor, quantidade) VALUES
(1, 1, 50),
(2, 3, 200),
(3, 1, 120);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    data_pedido DATE,
    status_pedido VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

INSERT INTO pedidos (id_cliente, data_pedido, status_pedido) VALUES
(1, '2025-10-01', 'Pago'),
(2, '2025-10-02', 'Pendente'),
(3, '2025-10-02', 'Enviado');

CREATE TABLE itens_pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_produto INT,
    quantidade INT,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

INSERT INTO itens_pedido (id_pedido, id_produto, quantidade) VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1);

CREATE TABLE pagamentos (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    valor DECIMAL(10,2),
    metodo VARCHAR(20),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);

INSERT INTO pagamentos (id_pedido, valor, metodo) VALUES
(1, 1000.00, 'Cartão'),
(1, 590.00, 'Pix'),
(2, 80.00, 'Boleto');

CREATE TABLE entregas (
    id_entrega INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    status_entrega VARCHAR(20),
    codigo_rastreio VARCHAR(50),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);

INSERT INTO entregas (id_pedido, status_entrega, codigo_rastreio) VALUES
(1, 'Enviado', 'BR123456789'),
(2, 'Aguardando', 'BR987654321'),
(3, 'Entregue', 'BR555888777');
