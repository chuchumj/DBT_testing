{%- set country_column_source = [ 'source_system', 'last_load_date']
 -%}

{{ config(materialized='view') }}

SELECT 
*,
{% for item in country_column_source %}
{{ get_last_load_date(item) }} as {{item}}
{% endfor %}
FROM `item-sales.household.item_sales_detail_v2`
limit 10 