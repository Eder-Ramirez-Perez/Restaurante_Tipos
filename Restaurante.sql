SELECT * FROM menu_items;

--Encontrar el número de artículos en el menú.
SELECT COUNT(menu_item_id) AS "Numero de articulos"
	FROM menu_items;

--¿Cuál es el artículo menos caro y el más caro en el menú?
SELECT item_name, price
	FROM menu_items
	WHERE price = (SELECT MAX (price) FROM menu_items) 
	OR price = (SELECT MIN (price) FROM menu_items);

--¿Cuántos platos americanos hay en el menú?
SELECT category, COUNT(*) AS numero_de_platos_americanos
FROM menu_items
WHERE category LIKE '%American%'
GROUP BY category;

--¿Cuál es el precio promedio de los platos?
SELECT ROUND(AVG(price),2) AS "Precio promedio_de_los_platos"
FROM menu_items;

SELECT * FROM order_details;

--¿Cuántos pedidos únicos se realizaron en total?

SELECT COUNT(DISTINCT order_id) AS pedidos_unicos
FROM order_details;

--¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?

SELECT item_id, order_id 
FROM order_details
WHERE item_id IS NOT NULL
ORDER BY item_id DESC
LIMIT 5;


--¿Cuándo se realizó el primer pedido y el último pedido?

SELECT 
    MIN(order_date) AS primer_pedido,
    MAX(order_date) AS ultimo_pedido
FROM order_details;


--¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?

SELECT COUNT(order_id) AS total_pedidos
FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-01-05';

--d)

SELECT od.order_details_id, od.item_id, mi.menu_item_id, mi.item_name
FROM order_details od
LEFT JOIN menu_items mi ON od.item_id = mi.menu_item_id;

--Cuantas ordenes pidieron comida mexicana
SELECT COUNT (DISTINCT order_id)
FROM order_details AS ord
LEFT JOIN menu_items AS mi
ON ord.item_id=mi.menu_item_id
where category='Mexican'

--Cuantas ordenes pidieron hamburguesa 
SELECT COUNT (DISTINCT order_id)
FROM order_details AS ord
LEFT JOIN menu_items AS mi
ON ord.item_id=mi.menu_item_id
where item_name='Hamburger'

--¿Cuales fueron los 5 platillos menos vendidos del menú?

SELECT mi.item_name, COUNT(ord.order_id) AS total_pedidos
FROM order_details AS ord
LEFT JOIN menu_items AS mi
ON ord.item_id = mi.menu_item_id
WHERE mi.item_name IS NOT NULL
GROUP BY mi.item_name
ORDER BY total_pedidos ASC
LIMIT 5;

--¿Cuales fueron los 5 platillos más vendidos del menú?

SELECT mi.item_name, COUNT(ord.order_id) AS total_pedidos
FROM order_details AS ord
LEFT JOIN menu_items AS mi
ON ord.item_id = mi.menu_item_id
WHERE mi.item_name IS NOT NULL
GROUP BY mi.item_name
ORDER BY total_pedidos DESC
LIMIT 5;

--¿Que tipo de comida es la preferida por los clientes?
SELECT mi.category, COUNT(ord.order_id) AS total_pedidos
FROM order_details AS ord
LEFT JOIN menu_items AS mi
ON ord.item_id = mi.menu_item_id
WHERE mi.category IS NOT NULL
GROUP BY mi.category
ORDER BY total_pedidos DESC
LIMIT 1;