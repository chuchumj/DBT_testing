{%- set column_to_hash = ["store", "country", region] -%}
{%- set column_list = [ "store", "country", "region", "JE_Code"] -%}
{%- set pry_key = "store" -%}
{%- set modified_date = "Date" -%}

{{process_intraday_change(pry_key, modified_date, column_list )}}
{{process_interday_change( pry_key, modified_date, column_list , column_to_hash)}}
--{{process_table_creating( pry_key, modified_date, column_list , column_to_hash)}}
--{{process_compare_history_table( pry_key, modified_date, column_list , column_to_hash)}}
