
CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(20)
);

INSERT INTO clientes (nome, email, telefone) VALUES
('João Silva', 'joao@email.com', '11999999999'),
('Maria Oliveira', 'maria@email.com', '11988888888'),
('Carlos Souza', 'carlos@email.com', '11977777777');

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
(1, 1590.00, 'Cartão'),
(2, 80.00, 'Pix'),
(3, 45.00, 'Boleto');
