-- =====================================
-- PROJETO: ANÁLISE DE VENDAS NORTHWIND
-- AUTOR: JOÃO PEDRO FERREIRA
-- =====================================

-- ====================================================
-- QUERY 1: PRODUTOS MAIS VENDIDOS
-- Objetivo:
-- Identificar os produtos com maior volume de vendas
-- ====================================================
SELECT
	p.product_id,
	p.product_name,
	c.category_name,
	SUM(o.quantity) AS quantidade_total_vendida
FROM categories c
INNER JOIN products p
	ON c.category_id = p.category_id
INNER JOIN order_details o
	ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name, c.category_name
ORDER BY quantidade_total_vendida DESC
LIMIT 10;


-- =====================================
-- QUERY 2: PRODUTOS QUE MAIS FATURAM
-- Objetivo:
-- Identificar os produtos com maior receita
-- =====================================
SELECT*FROM order_details;
SELECT
	p.product_id,
	p.product_name,
	c.category_name,
	SUM(o.quantity * o.unit_price) AS faturamento_total
FROM categories c
INNER JOIN products p
	ON c.category_id = p.category_id
INNER JOIN order_details o
	ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name, c.category_name
ORDER BY faturamento_total DESC
LIMIT 10;

-- =====================================
-- QUERY 3: Clientes com maior volume de pedidos
-- Objetivo:
-- Identificar os clientes que geraram mais volume de compra
-- =====================================
SELECT
	c.company_name,
	c. country,
	COUNT(o.order_id) AS quantidade_de_pedido
FROM customers c
INNER JOIN orders o
	ON c.customer_id = o.customer_id
GROUP BY c.company_name, c. country
ORDER BY quantidade_de_pedido DESC
LIMIT 10;

-- =====================================
-- QUERY 2: PRODUTOS QUE MAIS FATURAM
-- Objetivo:
-- Identificar os produtos com maior receita
-- =====================================
SELECT*FROM order_details;
SELECT
	p.product_id,
	p.product_name,
	c.category_name,
	SUM(o.quantity * o.unit_price) AS faturamento_total
FROM categories c
INNER JOIN products p
	ON c.category_id = p.category_id
INNER JOIN order_details o
	ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name, c.category_name
ORDER BY faturamento_total DESC
LIMIT 10;

-- ==================================================
-- QUERY 4: Paises  com maior volume de pedidos
-- Objetivo:
-- Identificar os países com maior volume de pedidos
-- ==================================================

SELECT
	c. country,
	COUNT(o.order_id) AS quantidade_de_pedido
FROM customers c
INNER JOIN orders o
	ON c.customer_id = o.customer_id
GROUP BY c.country
ORDER BY quantidade_de_pedido DESC
LIMIT 10;

-- =====================================
-- QUERY 5: Ticket Medio de pedidos
-- Objetivo:
-- calcular o ticket medio dos pedidos
-- =====================================
CREATE OR REPLACE VIEW vw_total_pedido AS 
SELECT
	o.customer_id,
	o.order_id,
	SUM(odet.unit_price * odet.quantity) AS _faturamento_total
FROM orders o
INNER JOIN order_details odet
 	ON o.order_id = odet.order_id
GROUP BY o.order_id, o.customer_id;

SELECT
	AVG(vw._faturamento_total) AS ticket_medio_pedido
FROM vw_total_pedido vw;
-- ===============================================================
-- QUERY 6: Clientes com mais receita
-- Objetivo:
-- Identificar quais clientes geraram mais receita para a empresa
-- ===============================================================
SELECT*FROM customers;
SELECT*FROM orders;
SELECT*FROM order_details;
SELECT
	c.customer_id,
	c.company_name,
	c.country,
	SUM(odd.unit_price* odd.quantity) AS faturamento_total
FROM customers c
INNER JOIN orders o 
	ON	 c.customer_id = o.customer_id
INNER JOIN order_details odd
 	ON o.order_id = odd.order_id
GROUP BY c.company_name, c.country, c.customer_id
ORDER BY faturamento_total DESC
LIMIT 10;

-- ===============================================================
-- QUERY 7: Produtos sem vendas
-- Objetivo:
-- Identificar quais produtos nunca foram vendidos
-- ===============================================================
SELECT
	p.product_id,
	p.product_name,
	c.category_name,
	p.unit_price
FROM products p
LEFT JOIN order_details odd
	ON p.product_id = odd.product_id
INNER JOIN categories c
	ON p.category_id = c.category_id
WHERE odd.product_id IS NULL
ORDER BY p.product_name;

-- ===============================================================
-- QUERY 8: categoria que mais fatura
-- Objetivo:
-- Identificar quais categorias mais faturam
-- ===============================================================
SELECT*FROM products;
SELECT*FROM categories;
SELECT*FROM order_details

SELECT
	c.category_name,
	SUM(odd.unit_price * odd.quantity) AS faturamento_categoria
FROM order_details odd
INNER JOIN products p
	ON odd.product_id = p.product_id
INNER JOIN Categories c
	ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY faturamento_categoria DESC
LIMIT 10;

-- ===============================================================
-- QUERY 9: Evolução de vendas por ano
-- Objetivo:
-- Identificar como as vendas evoluiram ao longo dos anos
-- ===============================================================
SELECT*FROM orders;
SELECT*FROM order_details;
SELECT
	o.order_date,
	SUM(odd.unit_price * quantity)
FROM orders
INNER JOIN order_details odd
	ON	o.order_id = odd.order_id
	

	