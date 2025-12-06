-- Tarea , caso practico: El restaurante "Sabores del Mundo", es conocido por su auténtica cocina y su ambiente
--acogedor.
--Este restaurante lanzó un nuevo menú a principios de año y ha estado recopilando
--información detallada sobre las transacciones de los clientes para identificar áreas de
--oportunidad y aprovechar al máximo sus datos para optimizar las ventas.--
--Objetivo:Identificar cuáles son los productos del menú que han tenido más éxito y cuales son los que
--menos han gustado a los clientes.

--b) Explorar la tabla “menu_items” para conocer los productos del menú.

SELECT *
FROM menu_items
ORDER BY menu_item_id;
-- se realiza un limit 10 
SELECT *
FROM menu_items
ORDER BY menu_item_id
LIMIT 10;
--1.- Realizar consultas para contestar las siguientes preguntas:
-- Encontrar el número de artículos en el menú.

SELECT COUNT(*) AS total_articulos
FROM menu_items;
--¿Cuál es el artículo menos caro y el más caro en el menú?

-- Artículo más barato
SELECT item_name, price
FROM menu_items
ORDER BY price ASC
LIMIT 1;

-- Artículo más caro
SELECT item_name, price
FROM menu_items
ORDER BY price DESC
LIMIT 1;
--¿Cuántos platos americanos hay en el menú?


SELECT COUNT(*) AS total_american
FROM menu_items
WHERE category = 'American';

--¿Cuál es el precio promedio de los platos?

SELECT AVG(price) AS precio_promedio
FROM menu_items;

--c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados.


SELECT *
FROM order_details
ORDER BY order_id;


--¿Cuántos pedidos únicos se realizaron en total?

SELECT COUNT(DISTINCT order_id) AS total_pedidos
FROM order_details;

--¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?


SELECT order_id,
       COUNT(*) AS total_articulos
FROM order_details
GROUP BY order_id
ORDER BY total_articulos DESC
LIMIT 5;

--¿Cuándo se realizó el primer pedido y el último pedido?


SELECT 
    MIN(order_date) AS primer_pedido,
    MAX(order_date) AS ultimo_pedido
FROM order_details;

---¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?


SELECT COUNT(DISTINCT order_id) AS total_pedidos
FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-01-05';

--Usar ambas tablas para conocer la reacción de los clientes respecto al menú.
1.-- Realizar un left join entre entre order_details y menu_items con el identificador
--item_id(tabla order_details) y menu_item_id(tabla menu_items).--

SELECT od.order_id,
       od.order_date,
       od.order_time,
       od.item_id,
       mi.menu_item_id,
       mi.item_name,
       mi.category,
       mi.price
FROM order_details od
LEFT JOIN menu_items mi
       ON od.item_id = mi.menu_item_id;

-- 5 platillos que mas se vendieron en cantidad de artículos--

SELECT mi.item_name,
       COUNT(*) AS total_vendido
FROM order_details od
LEFT JOIN menu_items mi
       ON od.item_id = mi.menu_item_id
GROUP BY mi.item_name
ORDER BY total_vendido DESC
LIMIT 5;
--5 platillos que menos se vendieron---

SELECT mi.item_name,
       COUNT(*) AS total_vendido
FROM order_details od
LEFT JOIN menu_items mi
       ON od.item_id = mi.menu_item_id
GROUP BY mi.item_name
ORDER BY total_vendido ASC
LIMIT 5;

--qué platillos generaron más ingresos--




SELECT mi.item_name,
       SUM(mi.price) AS ingreso_total
FROM order_details od
LEFT JOIN menu_items mi
       ON od.item_id = mi.menu_item_id
WHERE mi.menu_item_id IS NOT NULL
GROUP BY mi.item_name
ORDER BY ingreso_total DESC
LIMIT 5;

--cuántos artículos se vendieron y cuanto ingreso genero cada categoría:


SELECT mi.category,
       COUNT(*) AS total_articulos,
       SUM(mi.price) AS ingreso_total
FROM order_details od
LEFT JOIN menu_items mi
       ON od.item_id = mi.menu_item_id
WHERE mi.menu_item_id IS NOT NULL
GROUP BY mi.category
ORDER BY total_articulos DESC;

--Platillos con mayor ingreso promedio--

SELECT mi.item_name,
       AVG(mi.price) AS precio_promedio
FROM order_details od
LEFT JOIN menu_items mi
       ON od.item_id = mi.menu_item_id
WHERE mi.menu_item_id IS NOT NULL
GROUP BY mi.item_name
ORDER BY precio_promedio DESC
LIMIT 5;


--Platillos con menor ingreso promedio--

SELECT mi.item_name,
       AVG(mi.price) AS precio_promedio
FROM order_details od
LEFT JOIN menu_items mi
       ON od.item_id = mi.menu_item_id
WHERE mi.menu_item_id IS NOT NULL
GROUP BY mi.item_name
ORDER BY precio_promedio ASC
LIMIT 5;

---analisis adicional , platillos mas vendidos (popularidad)--

SELECT mi.item_name,
       COUNT(*) AS total_vendido
FROM order_details od
LEFT JOIN menu_items mi
       ON od.item_id = mi.menu_item_id
WHERE mi.menu_item_id IS NOT NULL
GROUP BY mi.item_name
ORDER BY total_vendido DESC
LIMIT 5;

--Platillos menos vendidos (oportunidad de mejora)

SELECT mi.item_name,
       COUNT(*) AS total_vendido
FROM order_details od
LEFT JOIN menu_items mi
       ON od.item_id = mi.menu_item_id
WHERE mi.menu_item_id IS NOT NULL
GROUP BY mi.item_name
ORDER BY total_vendido ASC
LIMIT 5;

--Ingreso total por platillo-- (rentabilidad)


SELECT mi.item_name,
       SUM(mi.price) AS ingreso_total
FROM order_details od
LEFT JOIN menu_items mi
       ON od.item_id = mi.menu_item_id
WHERE mi.menu_item_id IS NOT NULL
GROUP BY mi.item_name
ORDER BY ingreso_total DESC
LIMIT 5;

---Ventas e ingresos por categoría (preferencias generales)
SELECT mi.category,
       COUNT(*) AS total_articulos,
       SUM(mi.price) AS ingreso_total
FROM order_details od
LEFT JOIN menu_items mi
       ON od.item_id = mi.menu_item_id
WHERE mi.menu_item_id IS NOT NULL
GROUP BY mi.category
ORDER BY total_articulos DESC;

---platillos con mayor y menor ingreso promedio (segmentacion de precios)
--mayor ingreso promedio:
SELECT mi.item_name,
       AVG(mi.price) AS precio_promedio
FROM order_details od
LEFT JOIN menu_items mi
       ON od.item_id = mi.menu_item_id
WHERE mi.menu_item_id IS NOT NULL
GROUP BY mi.item_name
ORDER BY precio_promedio DESC
LIMIT 5;

----Menor ingreso promedio:

SELECT mi.item_name,
       AVG(mi.price) AS precio_promedio
FROM order_details od
LEFT JOIN menu_items mi
       ON od.item_id = mi.menu_item_id
WHERE mi.menu_item_id IS NOT NULL
GROUP BY mi.item_name
ORDER BY precio_promedio ASC
LIMIT 5;


