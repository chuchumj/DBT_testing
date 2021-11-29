{% set item_colmumns = ['item', 'JE_Code' ] %}

{{ config(materialized='table') }}


SELECT 
{% for i in item_colmumns %}
 concat(i, "_IDH") as item_idh
{% endfor %}
FROM `item-sales.household.item_sales_detail` 
where item = 'Toaster'
limit 10