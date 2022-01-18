{%- set column_to_hash = [ "Salesperson" ] -%} --removed pry key and date fields
{%- set column_list = [ "item", "Salesperson", "Date"] -%}
{%- set pry_key = "item" -%}
{%- set modified_date = "Date" -%}
{%- set dim_item_intraday_table = "item-sales.dbt_core_testing.dim_item_intraday_change" -%}
{%- set dim_item_interday_table = "item-sales.dbt_core_testing.dim_item_interday_change" -%}
{%- set dim_item_new_record = "item-sales.dbt_core_testing.dim_item_new_record" -%}
{%- set dim_item = "item-sales.dbt_core_testing.dim_item" -%}
{%- set source_table = "item-sales.household.item" -%} 
 

--Note: arguments are positional arguments to enable the macro naming to be general. It could cause a bug in the future if not properly used 
{% call set_sql_header(config) %}
{{process_intraday_change(pry_key, modified_date, column_list, dim_item_intraday_table, source_table)}}
{{process_interday_change( pry_key, modified_date, column_list , column_to_hash, dim_item_intraday_table, dim_item_interday_table)}}
{{process_table_creation( pry_key, modified_date, dim_item_interday_table, dim_item)}}
{{process_discard_existing_record( pry_key, modified_date, dim_item_interday_table, dim_item, dim_item_new_record)}}
{%- endcall %}


--To overide the default project(database) or dataset(schema) #} | a post script
{{ config(schema="dbt_core_testing", post_hook = process_metadata(dim_item) ) }} 
select * 
from {{dim_item_new_record}}


--Notes
--materialized: 'incremental' is used to configure instead of creating the table always
--Can use their metadata table or configure ours to load metadata manually


--Notes: How can we create incremental table manually
/*
{% if table_exists %}

insert into `{{destination_table}}` as
select * 
from `{{dim_item_new_record}}`

{% else %}

{{ config(schema="dbt_core_testing") }} 
select * 
from `{{dim_item_new_record}}`

{% endif %}
*/

