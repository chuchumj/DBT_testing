{# In this we used the built in dbt_utils module to get the has values instead of creating our own macro from scratch #}
{# You can set and use more that one value in your query and it runs good #}

{%- set column_to_hash = ["JE_Code", "country"] -%}
{%- set column_list = ["JE_Code", "country"] -%}

{{ config(materialized='view') }}


SELECT
{{ dbt_utils.surrogate_key(column_to_hash) }} as hash_value
, {{ dbt_utils.surrogate_key(column_list) }} as column_list
FROM `item-sales.household.item_sales_detail_v2` 
limit 10 