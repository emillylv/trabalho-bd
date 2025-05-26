-- Trabalho de Banco de Dados I, 2º período
-- Sistema de vendas

-- Criação de tabelas
CREATE TABLE Cliente(
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo_cliente CHAR(1) CHECK (tipo_cliente IN ('J','F')) NOT NULL
);
CREATE TABLE Cliente_Pessoa_Física (
    id INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    CONSTRAINT fk_cliente_pf FOREIGN KEY (id) REFERENCES Cliente(id)
);
CREATE TABLE Cliente_Pessoa_Jurídica (
    id INT PRIMARY KEY,
    razao_social VARCHAR(100) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    CONSTRAINT fk_cliente_pj FOREIGN KEY (id) REFERENCES Cliente(id)
);
CREATE TABLE Venda_Pedido (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    id_produto INT,
    data_venda DATE NOT NULL,
    data_entrega DATE NOT NULL,
    desconto DECIMAL(10,2),
    total_venda INT,
    CONSTRAINT fk_venda_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id),
    CONSTRAINT fk_venda_produto FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);
CREATE TABLE Produto (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(100),
    preco DECIMAL(10,2) NOT NULL,
    estoque_minimo INT NOT NULL,
    lote VARCHAR(50) NOT NULL
);
CREATE TABLE Estoque (
    id_produto INT,
    nome_produto VARCHAR(100),
    data_entrada DATE NOT NULL,
    quantidade INT NOT NULL,
    data_saida DATE,
    CONSTRAINT fk_estoque_produto FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);
CREATE TABLE Fabricacao (
    id_ordem_fabricacao INT PRIMARY KEY,
    id_produto INT NOT NULL,
    qtd_ordem_fabricacao INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_termino DATE NOT NULL,
    CONSTRAINT fk_produto_fab FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

CREATE TABLE Producao (
    id_producao INT PRIMARY KEY,
    id_ordem_fabricacao INT,
    id_produto INT,
    data_apuracao DATE NOT NULL,
    data_producao DATE NOT NULL,
    FOREIGN KEY (id_ordem_fabricacao) REFERENCES Fabricacao(id_ordem_fabricacao) ON DELETE CASCADE,
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto) ON DELETE CASCADE
);

CREATE TABLE Analise_Desempenho (
    id_produto INT,
    quantidade_vendida INT NOT NULL,
    lucro DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto) ON DELETE CASCADE
);

CREATE TABLE Pedido_Produto (
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (id_pedido, id_produto),
    CONSTRAINT fk_pedido_produto_pedido FOREIGN KEY (id_pedido) REFERENCES Venda_Pedido(id_pedido),
    CONSTRAINT fk_pedido_produto_produto FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

commit;


--*Registro do produto deve começar com 5550
--*Registro do cliente deve começar com 1, ou seja, o décimo segundo cliente terá o id 112
--*Registo da venda deve começar com 999
--*Registro de ordem de fabricação com 1110
--*Registro de produção com 2220
commit;
INSERT INTO Cliente (id, nome, tipo_cliente) VALUES
(11, 'Franciny Ehlke', 'F');

INSERT INTO Cliente (id, nome, tipo_cliente) VALUES
(12, 'Mari Maria', 'F');

INSERT INTO Cliente (id, nome, tipo_cliente) VALUES
(13, 'Ruby Rose', 'J');

INSERT INTO Cliente (id, nome, tipo_cliente) VALUES
(14, 'RomAnd', 'J');

INSERT INTO Cliente (id, nome, tipo_cliente) VALUES
(15, 'MAC Ltda', 'J');

INSERT INTO Cliente (id, nome, tipo_cliente) VALUES
(16, 'Distribuidora Makeup Ltda', 'J');

INSERT INTO Cliente (id, nome, tipo_cliente) VALUES
(17, 'Sephora Ltda', 'J');

INSERT INTO Cliente (id, nome, tipo_cliente) VALUES
(18, 'Karen Bachini', 'F');

INSERT INTO Cliente (id, nome, tipo_cliente) VALUES
(19, 'Bruna Tavares', 'F');

INSERT INTO Cliente (id, nome, tipo_cliente) VALUES
(110, 'Boca Rosa Beauty', 'F');

commit;


ALTER TABLE CLIENTE_PESSOA_FÍSICA
ADD id INT;

ALTER TABLE CLIENTE_PESSOA_FÍSICA
ADD CONSTRAINT pk_cliente_id PRIMARY KEY (id);

ALTER TABLE CLIENTE_PESSOA_FÍSICA
ADD CONSTRAINT fk_cliente_pf FOREIGN KEY (id) REFERENCES Cliente(id);
COMMIT;

-- Inserindo clientes na tabela Cliente_Pessoa_Física
INSERT INTO CLIENTE_PESSOA_FÍSICA(nome, cpf, id) VALUES
('Franciny Ehlke', '123.456.789-01', '11');

INSERT INTO CLIENTE_PESSOA_FÍSICA (id, nome, cpf) VALUES
(12, 'Mari Maria', '234.567.890-12');

INSERT INTO Cliente_Pessoa_Física (id, nome, cpf) VALUES
(18, 'Karen Bachini', '345.678.901-23');

INSERT INTO Cliente_Pessoa_Física (id, nome, cpf) VALUES
(19, 'Bruna Tavares', '456.789.012-34');

INSERT INTO Cliente_Pessoa_Física (id, nome, cpf) VALUES
(110, 'Boca Rosa Beauty', '567.890.123-45');

commit;

-- Inserindo clientes na tabela Cliente_Pessoa_Jurídica
INSERT INTO Cliente_Pessoa_Jurídica (id, razao_social, cnpj) VALUES
(13, 'Ruby Rose', '12.345.678/0001-98');

INSERT INTO Cliente_Pessoa_Jurídica (id, razao_social, cnpj) VALUES
(14, 'RomAnd', '23.456.789/0001-87');

INSERT INTO Cliente_Pessoa_Jurídica (id, razao_social, cnpj) VALUES
(15, 'MAC Ltda', '34.567.890/0001-76');

INSERT INTO Cliente_Pessoa_Jurídica (id, razao_social, cnpj) VALUES
(16, 'Distribuidora Makeup Ltda', '45.678.901/0001-65');

INSERT INTO Cliente_Pessoa_Jurídica (id, razao_social, cnpj) VALUES
(17, 'Sephora Ltda', '56.789.012/0001-54');

commit;

INSERT INTO ENDERECO (ID_ENDERECO, ID_CLIENTE, RUA, NUMERO, COMPLEMENTO, BAIRRO, CIDADE, ESTADO, CEP) VALUES
(1, 11, 'Rua da Bahia', 123, NULL, 'Centro', 'São Paulo', 'SP', '12345-678');

INSERT INTO ENDERECO (ID_ENDERECO, ID_CLIENTE, RUA, NUMERO, COMPLEMENTO, BAIRRO, CIDADE, ESTADO, CEP) VALUES
(2, 12, 'Rua Tupinanbás', 456, 'Apto 101', 'Bairro A', 'Rio de Janeiro', 'RJ', '23456-789');

INSERT INTO ENDERECO (ID_ENDERECO, ID_CLIENTE, RUA, NUMERO, COMPLEMENTO, BAIRRO, CIDADE, ESTADO, CEP) VALUES
(3, 13, 'Av. Principal', 789, NULL, 'Centro', 'Belo Horizonte', 'MG', '34567-890');

INSERT INTO ENDERECO (ID_ENDERECO, ID_CLIENTE, RUA, NUMERO, COMPLEMENTO, BAIRRO, CIDADE, ESTADO, CEP) VALUES
(4, 14, 'Rua Comercial', 1011, 'Sala 202', 'Centro', 'Brasília', 'DF', '45678-901');

INSERT INTO ENDERECO (ID_ENDERECO, ID_CLIENTE, RUA, NUMERO, COMPLEMENTO, BAIRRO, CIDADE, ESTADO, CEP) VALUES
(5, 15, 'Av. Principal', 1213, NULL, 'Centro', 'Curitiba', 'PR', '56789-012');

INSERT INTO ENDERECO (ID_ENDERECO, ID_CLIENTE, RUA, NUMERO, COMPLEMENTO, BAIRRO, CIDADE, ESTADO, CEP) VALUES
(6, 16, 'Rua dos Distribuidores', 1415, 'Loja 1', 'Bairro B', 'Porto Alegre', 'RS', '67890-123');

INSERT INTO ENDERECO (ID_ENDERECO, ID_CLIENTE, RUA, NUMERO, COMPLEMENTO, BAIRRO, CIDADE, ESTADO, CEP) VALUES
(7, 17, 'Av. Sephora', 1617, 'Loja 2', 'Bairro Serra', 'Salvador', 'BA', '78901-234');

INSERT INTO ENDERECO (ID_ENDERECO, ID_CLIENTE, RUA, NUMERO, COMPLEMENTO, BAIRRO, CIDADE, ESTADO, CEP) VALUES
(8, 18, 'Rua das Blogueiras', 1819, NULL, 'Bairro Amazonas', 'Florianópolis', 'SC', '89012-345');

INSERT INTO ENDERECO (ID_ENDERECO, ID_CLIENTE, RUA, NUMERO, COMPLEMENTO, BAIRRO, CIDADE, ESTADO, CEP) VALUES
(9, 19, 'Rua da Maquiagem', 1920, 'Apto 303', 'Centro', 'Fortaleza', 'CE', '90123-456');

INSERT INTO ENDERECO (ID_ENDERECO, ID_CLIENTE, RUA, NUMERO, COMPLEMENTO, BAIRRO, CIDADE, ESTADO, CEP) VALUES
(10, 110, 'Av. Rosa', 2021, NULL, 'Centro', 'Recife', 'PE', '01234-567');

commit;

INSERT INTO TELEFONE (ID_TELEFONE, ID_CLIENTE, NUMERO, DDD) VALUES
(1, 11, '987654321', '11');

INSERT INTO TELEFONE (ID_TELEFONE, ID_CLIENTE, NUMERO, DDD) VALUES
(2, 12, '876543210', '21');

INSERT INTO TELEFONE (ID_TELEFONE, ID_CLIENTE, NUMERO, DDD) VALUES
(3, 13, '765432109', '31');

INSERT INTO TELEFONE (ID_TELEFONE, ID_CLIENTE, NUMERO, DDD) VALUES
(4, 14, '654321098', '41');

INSERT INTO TELEFONE (ID_TELEFONE, ID_CLIENTE, NUMERO, DDD) VALUES
(5, 15, '543210987', '51');

INSERT INTO TELEFONE (ID_TELEFONE, ID_CLIENTE, NUMERO, DDD) VALUES
(6, 16, '432109876', '61');

INSERT INTO TELEFONE (ID_TELEFONE, ID_CLIENTE, NUMERO, DDD) VALUES
(7, 17, '321098765', '71');

INSERT INTO TELEFONE (ID_TELEFONE, ID_CLIENTE, NUMERO, DDD) VALUES
(8, 18, '210987654', '81');

INSERT INTO TELEFONE (ID_TELEFONE, ID_CLIENTE, NUMERO, DDD) VALUES
(9, 19, '109876543', '91');

INSERT INTO TELEFONE (ID_TELEFONE, ID_CLIENTE, NUMERO, DDD) VALUES
(10, 110, '012345678', '99');

commit;

--Cadastrando produtos
INSERT INTO Produto (id_produto, nome, descricao, preco, estoque_minimo, lote) VALUES
(55501, 'Base Líquida', 'Cobertura média, acabamento matte', 45.00, 100, 'BL2024');

INSERT INTO Produto (id_produto, nome, descricao, preco, estoque_minimo, lote) VALUES
(55502, 'Batom Matte', 'Vermelho intenso, longa duração', 30.00, 150, 'BM2024');

INSERT INTO Produto (id_produto, nome, descricao, preco, estoque_minimo, lote) VALUES
(55503, 'Paleta de Sombras', '12 cores vibrantes, alta pigmentação', 60.00, 200, 'PS2024');

INSERT INTO Produto (id_produto, nome, descricao, preco, estoque_minimo, lote) VALUES
(55504, 'Corretivo Líquido', 'Alta cobertura, disfarça imperfeições', 25.00, 200, 'CL2024');

INSERT INTO Produto (id_produto, nome, descricao, preco, estoque_minimo, lote) VALUES
(55505, 'Máscara de Cílios', 'Volume e alongamento', 35.00, 1000, 'MC2024');

INSERT INTO Produto (id_produto, nome, descricao, preco, estoque_minimo, lote) VALUES
(55506, 'Blush em Pó', 'Textura fina, efeito natural', 20.00, 900, 'BP2024');

INSERT INTO Produto (id_produto, nome, descricao, preco, estoque_minimo, lote) VALUES
(55507, 'Pó Compacto', 'Matifica e controla o brilho da pele', 30.00, 150, 'PC2024');

INSERT INTO Produto (id_produto, nome, descricao, preco, estoque_minimo, lote) VALUES
(55508, 'Delineador Líquido', 'Precisão no traçado, secagem rápida', 20.00, 10, 'PC2024');

INSERT INTO Produto (id_produto, nome, descricao, preco, estoque_minimo, lote) VALUES
(55509, 'Batom Líquido Matte', 'Longa duração, cores vibrantes', 28.00, 15, 'BP2024');

INSERT INTO Produto (id_produto, nome, descricao, preco, estoque_minimo, lote) VALUES
(555010, 'Iluminador em Bastão', 'Realça pontos de luz, acabamento cintilante', 22.00, 500, 'PC2024');

COMMIT;

--Cadastrando produtos no estoque
INSERT INTO ESTOQUE (ID_PRODUTO, NOME_PRODUTO, DATA_ENTRADA, QUANTIDADE, DATA_SAIDA) VALUES
(55501, 'Base Líquida', TO_DATE('2024-03-30', 'YYYY-MM-DD'), 200, TO_DATE('2024-04-01', 'YYYY-MM-DD'));

INSERT INTO ESTOQUE (ID_PRODUTO, NOME_PRODUTO, DATA_ENTRADA, QUANTIDADE, DATA_SAIDA) VALUES
(55502, 'Batom Matte', TO_DATE('2024-04-14', 'YYYY-MM-DD'), 300, TO_DATE('2024-04-30', 'YYYY-MM-DD'));

INSERT INTO ESTOQUE (ID_PRODUTO, NOME_PRODUTO, DATA_ENTRADA, QUANTIDADE, DATA_SAIDA) VALUES
(55503, 'Paleta de Sombras', TO_DATE('2024-05-01', 'YYYY-MM-DD'), 150, TO_DATE('2024-05-05', 'YYYY-MM-DD'));

INSERT INTO ESTOQUE (ID_PRODUTO, NOME_PRODUTO, DATA_ENTRADA, QUANTIDADE, DATA_SAIDA) VALUES
(55504, 'Corretivo Líquido', TO_DATE('2024-05-01', 'YYYY-MM-DD'), 250, TO_DATE('2024-05-15', 'YYYY-MM-DD'));

INSERT INTO ESTOQUE (ID_PRODUTO, NOME_PRODUTO, DATA_ENTRADA, QUANTIDADE, DATA_SAIDA) VALUES
(55505, 'Máscara de Cílios', TO_DATE('2024-05-01', 'YYYY-MM-DD'), 500, TO_DATE('2024-05-15', 'YYYY-MM-DD'));

INSERT INTO ESTOQUE (ID_PRODUTO, NOME_PRODUTO, DATA_ENTRADA, QUANTIDADE, DATA_SAIDA) VALUES
(55506, 'Blush em Pó', TO_DATE('2024-05-01', 'YYYY-MM-DD'), 800, TO_DATE('2024-05-19', 'YYYY-MM-DD'));

INSERT INTO ESTOQUE (ID_PRODUTO, NOME_PRODUTO, DATA_ENTRADA, QUANTIDADE, DATA_SAIDA) VALUES
(55507, 'Pó Compacto', TO_DATE('2024-05-27', 'YYYY-MM-DD'), 100, TO_DATE('2024-05-30', 'YYYY-MM-DD'));

INSERT INTO ESTOQUE (ID_PRODUTO, NOME_PRODUTO, DATA_ENTRADA, QUANTIDADE, DATA_SAIDA) VALUES
(55508, 'Delineador Líquido', TO_DATE('2024-05-01', 'YYYY-MM-DD'), 5, TO_DATE('2024-05-15', 'YYYY-MM-DD'));

INSERT INTO ESTOQUE (ID_PRODUTO, NOME_PRODUTO, DATA_ENTRADA, QUANTIDADE, DATA_SAIDA) VALUES
(55509, 'Batom Líquido Matte', TO_DATE('2024-05-01', 'YYYY-MM-DD'), 10, TO_DATE('2024-05-15', 'YYYY-MM-DD'));

INSERT INTO ESTOQUE (ID_PRODUTO, NOME_PRODUTO, DATA_ENTRADA, QUANTIDADE, DATA_SAIDA) VALUES
(555010, 'Iluminador em Bastão', TO_DATE('2024-05-20', 'YYYY-MM-DD'), 400, TO_DATE('2024-05-15', 'YYYY-MM-DD'));

commit;

ALTER TABLE VENDA_PEDIDO
ADD QUANTIDADE_PRODUTOS int;

commit;

-- Venda 1
INSERT INTO VENDA_PEDIDO (ID_PEDIDO, ID_CLIENTE, ID_PRODUTO, DATA_VENDA, DATA_ENTREGA, DESCONTO, QUANTIDADE_PRODUTOS, TOTAL_VENDA) 
VALUES (1, 11, 55501, TO_DATE('2024-05-01', 'YYYY-MM-DD'), TO_DATE('2024-05-10', 'YYYY-MM-DD'), 0, 2, (SELECT preco * 2 FROM Produto WHERE id_produto = 55501));

commit;

UPDATE VENDA_PEDIDO
SET ID_PEDIDO = 99901
WHERE ID_PEDIDO = 1;

commit;

-- Vendas
INSERT INTO VENDA_PEDIDO (ID_PEDIDO, ID_CLIENTE, ID_PRODUTO, DATA_VENDA, DATA_ENTREGA, DESCONTO, QUANTIDADE_PRODUTOS, TOTAL_VENDA) 
VALUES (99902, 12, 55502, TO_DATE('2024-05-05', 'YYYY-MM-DD'), TO_DATE('2024-05-15', 'YYYY-MM-DD'), 0, 1, (SELECT preco FROM Produto WHERE id_produto = 55502));


DELETE FROM VENDA_PEDIDO
WHERE ID_PEDIDO = 99903;
commit;


-- Vendas
INSERT INTO VENDA_PEDIDO (ID_PEDIDO, ID_CLIENTE, ID_PRODUTO, DATA_VENDA, DATA_ENTREGA, DESCONTO, QUANTIDADE_PRODUTOS, TOTAL_VENDA) 
VALUES (99903, 13, 55503, TO_DATE('2024-05-06', 'YYYY-MM-DD'), TO_DATE('2024-05-16', 'YYYY-MM-DD'), 0, 2, (SELECT preco FROM Produto WHERE id_produto = 55503) * 2);
commit;

INSERT INTO VENDA_PEDIDO (ID_PEDIDO, ID_CLIENTE, ID_PRODUTO, DATA_VENDA, DATA_ENTREGA, DESCONTO, QUANTIDADE_PRODUTOS, TOTAL_VENDA) 
VALUES (99904, 14, 55504, TO_DATE('2024-05-07', 'YYYY-MM-DD'), TO_DATE('2024-05-17', 'YYYY-MM-DD'), 0, 3, (SELECT preco FROM Produto WHERE id_produto = 55504) * 3);

INSERT INTO VENDA_PEDIDO (ID_PEDIDO, ID_CLIENTE, ID_PRODUTO, DATA_VENDA, DATA_ENTREGA, DESCONTO, QUANTIDADE_PRODUTOS, TOTAL_VENDA) 
VALUES (99905, 15, 55505, TO_DATE('2024-05-08', 'YYYY-MM-DD'), TO_DATE('2024-05-18', 'YYYY-MM-DD'), 0, 4, (SELECT preco FROM Produto WHERE id_produto = 55505) * 4);

INSERT INTO VENDA_PEDIDO (ID_PEDIDO, ID_CLIENTE, ID_PRODUTO, DATA_VENDA, DATA_ENTREGA, DESCONTO, QUANTIDADE_PRODUTOS, TOTAL_VENDA) 
VALUES (99906, 16, 55506, TO_DATE('2024-05-09', 'YYYY-MM-DD'), TO_DATE('2024-05-19', 'YYYY-MM-DD'), 0, 5, (SELECT preco FROM Produto WHERE id_produto = 55506) * 5);

INSERT INTO VENDA_PEDIDO (ID_PEDIDO, ID_CLIENTE, ID_PRODUTO, DATA_VENDA, DATA_ENTREGA, DESCONTO, QUANTIDADE_PRODUTOS, TOTAL_VENDA) 
VALUES (99907, 17, 55507, TO_DATE('2024-05-10', 'YYYY-MM-DD'), TO_DATE('2024-05-20', 'YYYY-MM-DD'), 0, 6, (SELECT preco FROM Produto WHERE id_produto = 55507) * 6);

INSERT INTO VENDA_PEDIDO (ID_PEDIDO, ID_CLIENTE, ID_PRODUTO, DATA_VENDA, DATA_ENTREGA, DESCONTO, QUANTIDADE_PRODUTOS, TOTAL_VENDA) 
VALUES (99908, 18, 55508, TO_DATE('2024-05-11', 'YYYY-MM-DD'), TO_DATE('2024-05-21', 'YYYY-MM-DD'), 0, 7, (SELECT preco FROM Produto WHERE id_produto = 55508) * 7);

INSERT INTO VENDA_PEDIDO (ID_PEDIDO, ID_CLIENTE, ID_PRODUTO, DATA_VENDA, DATA_ENTREGA, DESCONTO, QUANTIDADE_PRODUTOS, TOTAL_VENDA) 
VALUES (99909, 19, 55509, TO_DATE('2024-05-12', 'YYYY-MM-DD'), TO_DATE('2024-05-22', 'YYYY-MM-DD'), 0, 8, (SELECT preco FROM Produto WHERE id_produto = 55509) * 8);

INSERT INTO VENDA_PEDIDO (ID_PEDIDO, ID_CLIENTE, ID_PRODUTO, DATA_VENDA, DATA_ENTREGA, DESCONTO, QUANTIDADE_PRODUTOS, TOTAL_VENDA) 
VALUES (99910, 110, 555010, TO_DATE('2024-05-13', 'YYYY-MM-DD'), TO_DATE('2024-05-23', 'YYYY-MM-DD'), 0, 9, (SELECT preco FROM Produto WHERE id_produto = 555010) * 9);

INSERT INTO VENDA_PEDIDO (ID_PEDIDO, ID_CLIENTE, ID_PRODUTO, DATA_VENDA, DATA_ENTREGA, DESCONTO, QUANTIDADE_PRODUTOS, TOTAL_VENDA) 
VALUES (99911, 11, 55501, TO_DATE('2024-05-14', 'YYYY-MM-DD'), TO_DATE('2024-05-24', 'YYYY-MM-DD'), 0, 10, (SELECT preco FROM Produto WHERE id_produto = 55501) * 10);

COMMIT;

--Ordem de fabricação
--Deve começar com 1110
INSERT INTO FABRICACAO (ID_ORDEM_FABRICACAO, ID_PRODUTO, QTD_ORDEM_FABRICACAO, DATA_INICIO, DATA_TERMINO)
VALUES (1110, 55501, 1500, TO_DATE('2024-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-10', 'YYYY-MM-DD'));

INSERT INTO FABRICACAO (ID_ORDEM_FABRICACAO, ID_PRODUTO, QTD_ORDEM_FABRICACAO, DATA_INICIO, DATA_TERMINO)
VALUES (1111, 55502, 2000, TO_DATE('2024-06-02', 'YYYY-MM-DD'), TO_DATE('2024-06-11', 'YYYY-MM-DD'));

INSERT INTO FABRICACAO (ID_ORDEM_FABRICACAO, ID_PRODUTO, QTD_ORDEM_FABRICACAO, DATA_INICIO, DATA_TERMINO)
VALUES (1112, 55503, 1500, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-12', 'YYYY-MM-DD'));

INSERT INTO FABRICACAO (ID_ORDEM_FABRICACAO, ID_PRODUTO, QTD_ORDEM_FABRICACAO, DATA_INICIO, DATA_TERMINO)
VALUES (1113, 55504, 3000, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-13', 'YYYY-MM-DD'));

INSERT INTO FABRICACAO (ID_ORDEM_FABRICACAO, ID_PRODUTO, QTD_ORDEM_FABRICACAO, DATA_INICIO, DATA_TERMINO)
VALUES (1114, 55505, 2000, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-14', 'YYYY-MM-DD'));

INSERT INTO FABRICACAO (ID_ORDEM_FABRICACAO, ID_PRODUTO, QTD_ORDEM_FABRICACAO, DATA_INICIO, DATA_TERMINO)
VALUES (1115, 55506, 3000, TO_DATE('2024-06-06', 'YYYY-MM-DD'), TO_DATE('2024-06-15', 'YYYY-MM-DD'));

INSERT INTO FABRICACAO (ID_ORDEM_FABRICACAO, ID_PRODUTO, QTD_ORDEM_FABRICACAO, DATA_INICIO, DATA_TERMINO)
VALUES (1116, 55507, 1500, TO_DATE('2024-06-07', 'YYYY-MM-DD'), TO_DATE('2024-06-16', 'YYYY-MM-DD'));

INSERT INTO FABRICACAO (ID_ORDEM_FABRICACAO, ID_PRODUTO, QTD_ORDEM_FABRICACAO, DATA_INICIO, DATA_TERMINO)
VALUES (1117, 55508, 2000, TO_DATE('2024-06-08', 'YYYY-MM-DD'), TO_DATE('2024-06-17', 'YYYY-MM-DD'));

INSERT INTO FABRICACAO (ID_ORDEM_FABRICACAO, ID_PRODUTO, QTD_ORDEM_FABRICACAO, DATA_INICIO, DATA_TERMINO)
VALUES (1118, 55509, 2500, TO_DATE('2024-06-09', 'YYYY-MM-DD'), TO_DATE('2024-06-18', 'YYYY-MM-DD'));

INSERT INTO FABRICACAO (ID_ORDEM_FABRICACAO, ID_PRODUTO, QTD_ORDEM_FABRICACAO, DATA_INICIO, DATA_TERMINO)
VALUES (1119, 555010, 3500, TO_DATE('2024-06-10', 'YYYY-MM-DD'), TO_DATE('2024-06-19', 'YYYY-MM-DD'));

COMMIT;

--Produção (Deve começar com 2220 para identificá-la)
INSERT INTO PRODUCAO (ID_PRODUCAO, ID_ORDEM_FABRICACAO, ID_PRODUTO, DATA_APURACAO, DATA_PRODUCAO)
VALUES (22201, 1110, 55501, TO_DATE('2024-06-10', 'YYYY-MM-DD'), TO_DATE('2024-06-11', 'YYYY-MM-DD'));

INSERT INTO PRODUCAO (ID_PRODUCAO, ID_ORDEM_FABRICACAO, ID_PRODUTO, DATA_APURACAO, DATA_PRODUCAO)
VALUES (22202, 1111, 55502, TO_DATE('2024-06-11', 'YYYY-MM-DD'), TO_DATE('2024-06-12', 'YYYY-MM-DD'));

INSERT INTO PRODUCAO (ID_PRODUCAO, ID_ORDEM_FABRICACAO, ID_PRODUTO, DATA_APURACAO, DATA_PRODUCAO)
VALUES (22203, 1112, 55503, TO_DATE('2024-06-12', 'YYYY-MM-DD'), TO_DATE('2024-06-13', 'YYYY-MM-DD'));

INSERT INTO PRODUCAO (ID_PRODUCAO, ID_ORDEM_FABRICACAO, ID_PRODUTO, DATA_APURACAO, DATA_PRODUCAO)
VALUES (22204, 1113, 55504, TO_DATE('2024-06-13', 'YYYY-MM-DD'), TO_DATE('2024-06-14', 'YYYY-MM-DD'));

INSERT INTO PRODUCAO (ID_PRODUCAO, ID_ORDEM_FABRICACAO, ID_PRODUTO, DATA_APURACAO, DATA_PRODUCAO)
VALUES (22205, 1114, 55505, TO_DATE('2024-06-14', 'YYYY-MM-DD'), TO_DATE('2024-06-15', 'YYYY-MM-DD'));

INSERT INTO PRODUCAO (ID_PRODUCAO, ID_ORDEM_FABRICACAO, ID_PRODUTO, DATA_APURACAO, DATA_PRODUCAO)
VALUES (22206, 1115, 55506, TO_DATE('2024-06-15', 'YYYY-MM-DD'), TO_DATE('2024-06-16', 'YYYY-MM-DD'));

INSERT INTO PRODUCAO (ID_PRODUCAO, ID_ORDEM_FABRICACAO, ID_PRODUTO, DATA_APURACAO, DATA_PRODUCAO)
VALUES (22207, 1116, 55507, TO_DATE('2024-06-16', 'YYYY-MM-DD'), TO_DATE('2024-06-17', 'YYYY-MM-DD'));

INSERT INTO PRODUCAO (ID_PRODUCAO, ID_ORDEM_FABRICACAO, ID_PRODUTO, DATA_APURACAO, DATA_PRODUCAO)
VALUES (22208, 1117, 55508, TO_DATE('2024-06-17', 'YYYY-MM-DD'), TO_DATE('2024-06-18', 'YYYY-MM-DD'));

INSERT INTO PRODUCAO (ID_PRODUCAO, ID_ORDEM_FABRICACAO, ID_PRODUTO, DATA_APURACAO, DATA_PRODUCAO)
VALUES (22209, 1118, 55509, TO_DATE('2024-06-18', 'YYYY-MM-DD'), TO_DATE('2024-06-19', 'YYYY-MM-DD'));

INSERT INTO PRODUCAO (ID_PRODUCAO, ID_ORDEM_FABRICACAO, ID_PRODUTO, DATA_APURACAO, DATA_PRODUCAO)
VALUES (22210, 1119, 555010, TO_DATE('2024-06-19', 'YYYY-MM-DD'), TO_DATE('2024-06-20', 'YYYY-MM-DD'));

COMMIT;

--Análise de desempenho do produto

COMMIT;

ALTER TABLE ANALISE_DESEMPENHO
MODIFY (LUCRO NUMBER(10, 2));

DELETE FROM ANALISE_DESEMPENHO;

--Análise de desempenho
INSERT INTO ANALISE_DESEMPENHO (ID_PRODUTO, QUANTIDADE_VENDIDA, LUCRO)
SELECT ID_PRODUTO, SUM(QUANTIDADE_PRODUTOS), SUM(TOTAL_VENDA)
FROM VENDA_PEDIDO
GROUP BY ID_PRODUTO;

COMMIT;

-- Views

--1)Cliente da fábrica que mais efetua compras:
CREATE VIEW TopClientes AS
SELECT c.ID, c.nome, SUM(vp.TOTAL_VENDA) AS total_compras
FROM VENDA_PEDIDO vp
JOIN CLIENTE c ON vp.ID_CLIENTE = c.ID
GROUP BY c.ID, c.nome
ORDER BY total_compras DESC;

--2)Produtos em estoque
CREATE VIEW vw_produto_estoque AS
SELECT p.id_produto, p.nome, p.descricao, p.preco, e.quantidade
FROM Produto p
JOIN Estoque e ON p.id_produto = e.id_produto;

--3)Movimentação de estoque
CREATE VIEW MovimentacaoEstoque AS
SELECT 
    'Fabricação' AS tipo_movimento,
    p.id_produto,
    p.nome AS nome_produto,
    NULL AS id_pedido,
    f.id_ordem_fabricacao AS id_movimento,
    f.data_inicio AS data_movimento,
    f.qtd_ordem_fabricacao AS quantidade_movimentada
FROM Fabricacao f
JOIN Produto p ON p.id_produto = f.id_produto

UNION ALL

SELECT 
    'Produção' AS tipo_movimento,
    p.id_produto,
    p.nome AS nome_produto,
    NULL AS id_pedido,
    pr.id_producao AS id_movimento,
    pr.data_producao AS data_movimento,
    NULL AS quantidade_movimentada
FROM Producao pr
JOIN Produto p ON p.id_produto = pr.id_produto

UNION ALL

SELECT 
    'Venda' AS tipo_movimento,
    p.id_produto,
    p.nome AS nome_produto,
    v.id_pedido,
    v.id_pedido AS id_movimento,
    v.data_venda AS data_movimento,
    NULL AS quantidade_movimentada
FROM Venda_Pedido v
JOIN Produto p ON p.id_produto = v.id_produto

UNION ALL

SELECT 
    'Baixa' AS tipo_movimento,
    e.id_produto,
    p.nome AS nome_produto,
    NULL AS id_pedido,
    NULL AS id_movimento,
    e.data_saida AS data_movimento,
    e.quantidade AS quantidade_movimentada
FROM Estoque e
JOIN Produto p ON p.id_produto = e.id_produto;

--4)Produtos mais vendidos
CREATE VIEW Mais_Vendidos AS
SELECT 
    p.id_produto,
    p.nome AS nome_produto,
    SUM(v.quantidade_produtos) AS total_produtos_vendidos
FROM Produto p
JOIN Venda_Pedido v ON p.id_produto = v.id_produto
GROUP BY p.id_produto, p.nome
ORDER BY total_produtos_vendidos DESC;

--5)Produtos que precisam ser fsbricados:
CREATE VIEW Produtos_Producao_Necessaria AS
SELECT 
    p.id_produto,
    p.nome AS nome_produto,
    p.descricao,
    p.preco,
    p.estoque_minimo,
    e.quantidade AS quantidade_em_estoque
FROM Produto p
JOIN (
    SELECT 
        id_produto,
        SUM(quantidade) AS quantidade
    FROM Estoque
    GROUP BY id_produto
) e ON p.id_produto = e.id_produto
WHERE e.quantidade < p.estoque_minimo;


COMMIT;

--Trigger para que os dados sejam inseridos automaticamente na tabela pedido_produto
CREATE TRIGGER after_insert_venda_pedido
AFTER INSERT ON Venda_Pedido
FOR EACH ROW
BEGIN
    INSERT INTO Pedido_Produto (id_pedido, id_produto, quantidade)
    VALUES (NEW.id_pedido, NEW.id_produto, NEW.quantidade);
END;

--Inserindo os dados na tabela pedido_produto manualmente pq não sabia usar trigger
INSERT INTO Pedido_Produto (id_pedido, id_produto, quantidade)
VALUES (99902, 55502, 1);

INSERT INTO Pedido_Produto (id_pedido, id_produto, quantidade)
VALUES (99903, 55503, 2);

INSERT INTO Pedido_Produto (id_pedido, id_produto, quantidade)
VALUES (99904, 55504, 3);

INSERT INTO Pedido_Produto (id_pedido, id_produto, quantidade)
VALUES (99905, 55505, 4);

INSERT INTO Pedido_Produto (id_pedido, id_produto, quantidade)
VALUES (99906, 55506, 5);

INSERT INTO Pedido_Produto (id_pedido, id_produto, quantidade)
VALUES (99907, 55507, 6);

INSERT INTO Pedido_Produto (id_pedido, id_produto, quantidade)
VALUES (99908, 55508, 7);

INSERT INTO Pedido_Produto (id_pedido, id_produto, quantidade)
VALUES (99909, 55509, 8);

INSERT INTO Pedido_Produto (id_pedido, id_produto, quantidade)
VALUES (99910, 555010, 9);

INSERT INTO Pedido_Produto (id_pedido, id_produto, quantidade)
VALUES (99911, 55501, 10);

commit;

--Fim