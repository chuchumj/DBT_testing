--Transformation step 2: Process interday changes
{% macro process_interday_change( pry_key, modified_date,column_list, column_to_hash, intraday_table, interday_table ) %}

Create or replace table {{interday_table}} as 
with hashed_records as ( 
  select 
    {% for field in column_list %}
    {{field}},
    {% endfor %} 
    {{ dbt_utils.surrogate_key(column_to_hash) }} AS hashed_value
  from {{intraday_table}}
  ),
previous_hashed_records as (
select 
  *
  , lag(hashed_value, 1) over(partition by {{pry_key}} order by {{modified_date}}) as previous_row
  from hashed_records
)
select
  * except ( previous_row)
  , row_number() over(partition by {{pry_key}} order by {{modified_date}}) as row_number
from previous_hashed_records
where (hashed_value != previous_row) or previous_row is null 
order by {{pry_key}}, {{modified_date}};

{% endmacro %}