WITH detalles_ventas AS (
  SELECT 
  oi.sale_price,
  p.cost,
  p.name AS producto_nombre,
  p.category AS categoria,
  (oi.sale_price - p.cost) AS ganancia_neta_objeto
  FROM
  `bigquery-public-data.thelook_ecommerce.order_items` AS oi
  JOIN
  `bigquery-public-data.thelook_ecommerce.products` AS p
  ON oi.product_id = p.id
  WHERE oi.status = 'Complete'
)

SELECT 
  producto_nombre,
  categoria,
  COUNT(*) AS total_unidades_vendidas,
  ROUND(SUM(sale_price), 2) AS ingresos_totales,
  ROUND(SUM(cost), 2) AS costos_totales,
  ROUND(SUM(ganancia_neta_objeto), 2) AS ganancia_neta_total,
  ROUND((SUM(ganancia_neta_objeto) / SUM(sale_price)) * 100, 2) AS porcentaje_margen
FROM 
  detalles_ventas
GROUP BY
  producto_nombre, categoria
ORDER BY
  ganancia_neta_total DESC;