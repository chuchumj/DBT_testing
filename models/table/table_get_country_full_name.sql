{%- set country_column = ['country_code']
 -%}

{{ config(materialized='view') }}



SELECT 
*,
{% for item in country_column %}
{{ get_country_full_name(item) }} as country_full_name
{% endfor %}
FROM `item-sales.household.item_sales_detail_v2` 
limit 10 