{# In this we used the built in dbt_utils module to get the has values instead of creating our own macro from scratch #}

{%- set column_to_hash = ["JE_Code", "country"]
      
 -%}

{{ config(materialized='view') }}


SELECT
{{ dbt_utils.surrogate_key(*column_to_hash) }}
FROM `item-sales.household.item_sales_detail_v2` 
limit 10 