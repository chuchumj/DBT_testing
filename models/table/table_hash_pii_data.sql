{%- set table_column = ["JE_Code", "country_code", "Store"]
      
 -%}

{{ config(materialized='view') }}



SELECT
{% for item in table_column %}
{{ hash_pii_data(item) }},
{% endfor %}
FROM `item-sales.household.item_sales_detail_v2` 
limit 10 