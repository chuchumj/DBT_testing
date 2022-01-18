{%- set column_to_hash = [ "country", "region"] -%} --removed pry key and date fields
{%- set column_list = [ "store", "country", "region", "Date"] -%}
{%- set pry_key = "store" -%}
{%- set modified_date = "Date" -%}
{%- set dim_store_intraday_table = "item-sales.dbt_core_testing.dim_store_intraday_change" -%}
{%- set dim_store_interday_table = "item-sales.dbt_core_testing.dim_store_interday_change" -%}
{%- set dim_store_new_record = "item-sales.dbt_core_testing.dim_store_new_record" -%}
{%- set dim_store = "item-sales.dbt_core_testing.dim_store" -%}
{%- set source_table = "item-sales.household.store" -%} 


--Note: arguments are positional arguments to enable the macro naming to be general. It could cause a bug in the future if not properly used 
{% call set_sql_header(config) %}
{{process_intraday_change(pry_key, modified_date, column_list, dim_store_intraday_table, source_table )}}
{{process_interday_change( pry_key, modified_date, column_list , column_to_hash, dim_store_intraday_table, dim_store_interday_table)}}
{{process_table_creation( pry_key, modified_date, dim_store_interday_table, dim_store)}}
{{process_discard_existing_record( pry_key, modified_date, dim_store_interday_table, dim_store, dim_store_new_record)}}
{%- endcall %}


--To overide the default project(database) or dataset(schema) #} | a post script
{{ config(schema="dbt_core_testing", post_hook = process_metadata(dim_store) ) }} 
select * 
from {{dim_store_new_record}}