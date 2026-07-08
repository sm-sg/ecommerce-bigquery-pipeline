WITH pasos_sesion AS (
  SELECT session_id, 
  MAX(CASE WHEN event_type = 'product' THEN 1 ELSE 0 END) AS visita_producto,
  MAX(CASE WHEN event_type = 'cart' THEN 1 ELSE 0 END) AS agrego_carrito,
  MAX(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS compra_exitosa,
  FROM
  `bigquery-public-data.thelook_ecommerce.events`
  GROUP BY
  session_id
)

SELECT 
  SUM(visita_producto) AS total_sesion_visita,
  SUM(agrego_carrito) AS total_sesion_carrito,
  SUM(compra_exitosa) AS total_sesion_compra,

  ROUND((SUM(agrego_carrito)/SUM(visita_producto))* 100, 2) AS tasa_agrega_carrito,
  ROUND((SUM(compra_exitosa)/SUM(agrego_carrito))* 100, 2) AS tasa_compra_exitosa,
FROM pasos_sesion;