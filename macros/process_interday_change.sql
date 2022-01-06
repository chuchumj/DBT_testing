--Transformation step 2: Process interday changes
{% macro process_interday_change( pry_key, modified_date,column_list, column_to_hash ) %}

with hashed_records as ( 
  select 
    {% for field in column_list %}
    {{field}},
    {% endfor %} 
    --, MD5(CAST(Id AS STRING) || CAST(Name AS STRING) || CAST(StageName AS STRING) || CAST(COALESCE(Amount, 0) AS STRING) || CAST(IsWon AS STRING))  AS hashed_value
    {{ dbt_utils.surrogate_key(column_to_hash) }}
  from `item-sales.dbt_core_testing.process_intraday_changes`
  ),
previous_hashed_records as (
select 
  *
  , lag(hashed_value, 1) over(partition by id order by LastModifiedDate) as previous_row
  from hashed_records
)
select
  * except ( previous_row)
  , row_number() over(partition by id order by LastModifiedDate) as row_number
from previous_hashed_records
where (hashed_value != previous_row) or previous_row is null 
order by id, LastModifiedDate;

{% endmacro %}