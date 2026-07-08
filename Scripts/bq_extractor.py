from google.cloud import bigquery
import pandas as pd
import os
def extraer_alertas_inventario():
    client = bigquery.Client()

    print("Conectando a BigQuery")
    query = """
    WITH conteo_inventario AS (
    SELECT
    product_id,
    COUNT(CASE WHEN sold_at IS NULL THEN 1 END) AS unidades_disponibles
    FROM 
    `bigquery-public-data.thelook_ecommerce.inventory_items`
    GROUP BY 
    product_id
    )

    SELECT 
    p.id AS producto_id,
    p.name AS producto_nombre,
    p.category AS categoria,
    p.retail_price AS precio_venta,
    inv.unidades_disponibles
    FROM 
    conteo_inventario AS inv
    JOIN
    `bigquery-public-data.thelook_ecommerce.products` AS p
    ON inv.product_id = p.id
    WHERE 
    inv.unidades_disponibles < 5
    ORDER BY
    inv.unidades_disponibles ASC,
    precio_venta DESC;
    """
    query_job = client.query(query)
    df = query_job.to_dataframe()

    output_path = "reporte_inventario_critico.csv"
    df.to_csv(output_path, index = False, encoding= 'utf-8')
    
    print(f"El reporte ha sido creado exitosamente en: {os.path.abspath(output_path)}")

if __name__ == "__main__":
    print("Entrando al bloque principal con éxito")
    extraer_alertas_inventario()