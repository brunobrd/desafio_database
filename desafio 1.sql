create database ecommerce;
use ecommerce;

-- criando tabela de cliente

create table Cliente(
IdCliente int auto_increment primary key,
Nome varchar(10),
Sobrenome varchar(45),
CPF char(11) not null,
Endereço varchar(45),
constraint unique_cpf_cliente unique(CPF)
);

-- criando tabela produto

create table Produto (
IdProduto int auto_increment primary key,
Nome varchar(45) not null,
Classificação_idade varchar(2),
Categoria enum("Eletrônico", "Vestimento", "Brinquedo", "Alimento"),
Endereço varchar(45),
Classificação float default 0 ,
Tamanho varchar(10)
);

-- criando a tabela pedido

create table Pedido (
IdPedido int auto_increment primary key,
IdPedidoCliente int,
StatusPedido enum ("Cancelado", "Confirmado", "Em processamento") not null,
Descrição varchar(255),
DescriçãoFrete float,
Forma_pagamento bool default false,
constraint fk_pedido_cliente foreign key(IdPedidoCliente) references Cliente(IdCliente)
);

create table Forma_de_pagamento (
IdForma_de_pagamento int not null primary key,
Tipo_pagamento enum("Boleto", "Pix", "Cartão de Debito", "Cartão de Credito")
);

create table Estoque (
IdProduto_Estoque int auto_increment not null primary key,
Localização varchar(255),
Quantidade int
);

create table Fornecedor (
IdFornecedor int auto_increment not null primary key,
NomeSocial varchar(45) not null,
CNPJ char(15) not null,
Contato char(11) not null,
constraint Fornecedor_unico unique(CNPJ)
);

create table Vendedor (
 IdVendedor int auto_increment not null	primary key,
 NomeSocial varchar(45),
 CNPJ char(11),
 Contato char(11) not null,
 Localização varchar(255),
 constraint Vendedor_unico unique(CNPJ)
 );
 
 create table Vendedor_Produto (
 IdPVendedor int not null,
 IdProduto int,
 Quantidade int not null,
 primary key (IdPVendedor, IdProduto),
 constraint fk_produto_vendedor foreign key(IdPVendedor) references Vendedor(IdVendedor),
 constraint fk_produto_produto foreign key(IdProduto) references Produto(IdProduto)
 );
 
 create table Produto_pedido (
 IdProduto_pedido int not null,
 Nome_produto int not null,
 Quantidade_produto int,
 Produto_status enum("Disponivel", "Sem Estoque") default "Disponivel",
 primary key (IdProduto_pedido, Nome_produto),
 constraint fk_produto_vendido foreign key (IdProduto_pedido) references Produto(IdProduto),
 constraint fk_produto_pedido foreign key (Nome_produto) references Pedido(IdPedido)
 );
 
 create table Local_loja (
 IdLocal_loja int,
 IdLocal_produto int,
 Localidade varchar(255),
 primary key(IdLocal_loja, IdLocal_produto),
 constraint fk_produto_vendido_loja foreign key (IdLocal_loja) references Estoque(IdProduto_Estoque),
 constraint fk_produto_loja foreign key (IdLocal_produto) references Produto(IdProduto)
 );
 
 insert into Cliente (Nome, Sobrenome, CPF, Endereço)
		values('Pedro', 'Alves', '12345678901', 'Rua João - Fortaleza'),
			  ('André', 'Diaz', '12345678902', 'Rua Pedro - Fortaleza'),
              ('Ana', 'Gomes', '12345678904', 'Rua J - Fortaleza');

insert into Produto (Nome, Classificação_idade, Categoria, Tamanho)
		values("fone de ouvido", "12", null, null),
			  ("carrinho hot whells",'4', null, null),
              ("max stell", "8", null, null);
              
