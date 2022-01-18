--Transformation step 2: Process interday changes
{% macro process_table_creation( pry_key, modified_date, interday_table, history_table ) %}

create table if not exists {{history_table}} as
  select 
    * except ( row_number)
    , current_date() as valid_to_date
  from {{interday_table}}
  where 1=2;

{% endmacro %}