# Ecommerce Data Pipeline: BigQuery a Análisis Local

Este proyecto implementa un pipeline de datos de extremo a extremo (End-to-End) que extrae, transforma y automatiza reportes operativos y analíticos clave para una tienda de comercio electrónico. Utiliza el dataset público institucional `thelook_ecommerce` alojado en Google BigQuery, procesando métricas de negocio críticas mediante SQL avanzado y automatizando la descarga local segura con Python.

---

## Arquitectura y Flujo del Pipeline

1. **Data Warehouse (Google BigQuery):** Almacenamiento y procesamiento pesado de datos brutos a través de consultas analíticas optimizadas (SQL).
2. **Capa de Autenticación Segura (GCP ADC):** Conexión local mediante *Application Default Credentials* (ADC) con la CLI de Google Cloud, evitando el riesgo de seguridad de exponer llaves JSON tradicionales.
3. **Capa de Automatización (Python & Pandas):** Script modular en Python que ejecuta las consultas, transforma los tipos de datos relacionales y exporta reportes optimizados en formato CSV de manera automatizada.

---

## Consultas Analíticas Desarrolladas (SQL)

El proyecto incluye tres reportes críticos diseñados para la toma de decisiones:

### 1. Rentabilidad por Producto y Categoría (`1_ganancia_producto.sql`)
* **Lógica:** Calcula los márgenes de ganancia brutos cruzando costos y precios de venta mediante `JOINs`, identificando los productos más valiosos para el negocio.

### 2. Embudo de Conversión Web (`2_tasas_de_eventos.sql`)
* **Desafío Técnico Resuelto:** Inicialmente, el conteo bruto de eventos duplicaba las métricas de comportamiento. Se reestructuró la lógica utilizando **modelado por sesiones (`session_id`)** en lugar de filas crudas. 
* **Resultado:** Se obtuvo la tasa de conversión real del negocio (Tasa de añadir al carrito: **63.3%** | Tasa de compra completada: **41.9%**).

### 3. Alertas de Inventario Crítico (`3_unidades_disponibles_inventario.sql`)
* **Desafío Técnico Resuelto:** La tabla de inventario no cuenta con un campo de estado (`status`). Se diseñó una agregación condicional evaluando campos temporales nulos:
  ```sql
  COUNT(CASE WHEN sold_at IS NULL THEN 1 END) AS unidades_disponibles


Bases de Datos: Google BigQuery (SQL Estándar).

Lenguaje: Python.

Librerías Principales: google-cloud-bigquery, pandas, pyarrow.

Entorno: Entorno Virtual Aislado (.venv) y Google Cloud CLI (gcloud).