# E-commercer---DIO-MySQL

Este repositório contém o esquema de banco de dados para um sistema de e-commerce, desenvolvido para armazenar informações de clientes, produtos, pedidos, pagamentos, entregas e fornecedores. O banco de dados foi modelado com chaves primárias e estrangeiras, bem como com dados de teste para facilitar a validação e o uso de consultas SQL.

Objetivo
O objetivo deste projeto é criar um banco de dados relacional que suporte um e-commerce, gerenciando diferentes aspectos da operação, como:

Cadastro de clientes (Pessoa Física e Jurídica).
Controle de produtos e estoque.
Processamento de pedidos e pagamentos.
Rastreamento de entregas.
Relacionamento com fornecedores.
Estrutura do Banco de Dados
Tabelas Criadas
clientes: Armazena informações sobre os clientes, com suporte para pessoa física (PF) e jurídica (PJ).
produtos: Contém os detalhes dos produtos vendidos no e-commerce, incluindo nome, descrição, preço e estoque.
pedidos: Registra os pedidos feitos pelos clientes, incluindo o status do pedido e a data de criação.
itens_pedido: Armazena os itens de cada pedido, com a quantidade e preço unitário dos produtos.
pagamentos: Registra os pagamentos realizados pelos clientes, com a forma de pagamento e o valor pago.
entregas: Contém as informações sobre a entrega de cada pedido, incluindo o status da entrega e o código de rastreio.
Relacionamentos
clientes está relacionado com pedidos.
pedidos está relacionado com itens_pedido, pagamentos e entregas.
itens_pedido está relacionado com produtos.
Consultas SQL
Exemplos de consultas SQL para obter informações sobre o e-commerce:

Quantos pedidos foram feitos por cada cliente?

sql
Copiar
Editar
SELECT cliente_id, COUNT(*) AS total_pedidos
FROM pedidos
GROUP BY cliente_id;
Relação de produtos e fornecedores

sql
Copiar
Editar
SELECT p.nome AS produto, f.nome AS fornecedor
FROM produtos p
JOIN fornecedores f ON p.id = f.id;
Listar pedidos pagos e seus valores

sql
Copiar
Editar
SELECT p.id AS pedido_id, c.nome AS cliente, p.status, pg.valor
FROM pedidos p
JOIN clientes c ON p.cliente_id = c.id
JOIN pagamentos pg ON p.id = pg.pedido_id
WHERE p.status = 'Pago';
Como Usar
Clone o repositório:

bash
Copiar
Editar
git clone https://github.com/nrmendf/ecommerce.git
Abra o arquivo ecommerce.sql no MySQL Workbench:

No MySQL Workbench, vá em File -> Open SQL Script... e selecione o arquivo ecommerce.sql.
Execute o script SQL para criar o banco de dados e as tabelas.
Inserir dados de teste:

O script já inclui dados de exemplo para clientes, produtos, pedidos, pagamentos e entregas.
Executar Consultas SQL:

Após criar o banco de dados e inserir os dados, execute as consultas SQL para realizar análises e obter relatórios sobre os dados.
Tecnologias Utilizadas
MySQL: Banco de dados relacional para armazenar os dados do e-commerce.
SQL: Linguagem para criação de tabelas, manipulação de dados e realização de consultas.
Instalação
Instale o MySQL: Caso ainda não tenha o MySQL instalado, você pode baixá-lo aqui.
Instale o MySQL Workbench: Baixe e instale o MySQL Workbench aqui.
Contribuições
Sinta-se à vontade para contribuir com melhorias no modelo de banco de dados, sugestões de novas funcionalidades ou correções de erros.
