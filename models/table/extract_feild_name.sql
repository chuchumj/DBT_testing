{%- set table_column = ["head.JE_Code", "head.country"]
      
 -%}

{{ config(materialized='view') }}


{#Split is not working here becuase you're not calling a macro but it's within the macro {{}} #}
SELECT
{% for item in table_column %}
{{ extract_feild_name(ARRAY_REVERSE(split(item, '.'))[offset(0)]) }},
{% endfor %}
FROM `item-sales.household.item_sales_detail_v2` 
limit 10 