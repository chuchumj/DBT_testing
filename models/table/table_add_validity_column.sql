
{{ config(materialized='view') }}


{#Split is not working here becuase you're not calling a macro but it's within the macro {{}} #}
SELECT
*,
{{ add_validity_column('Date','JE_Code') }} as valid_to_date
FROM `item-sales.household.item_sales_detail_v2` 
limit 10 