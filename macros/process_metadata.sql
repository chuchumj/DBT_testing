{% macro process_metadata(target_table) %}

CREATE TABLE IF NOT EXISTS  `item-sales.dbt_core_testing.metadata` as
select 
    split('{{target_table}}', '.')[offset(2)] as table_name
    , current_timestamp() as load_date;

{% endmacro %}