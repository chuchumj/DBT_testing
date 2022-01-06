--Transformation step 1: Process intraday changes
{% macro process_intraday_change( pry_key, modified_date, column_list) %}

with records as ( 
select 
  {% for field in column_list %}
  {{field}},
  {% endfor %} 
  row_number() over(partition by pry_key, date(modified_date) order by modified_date desc)  as row_number 
from `item-sales.household.item_sales_detail`
)
select 
  * except(row_number)
from records
where row_number = 1 
order by pry_key, modified_date;

{% endmacro %}