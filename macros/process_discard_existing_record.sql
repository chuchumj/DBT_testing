--check if record exist in history table
{% macro process_discard_existing_record( pry_key, modified_date, interday_table, history_table, new_record_table ) %}

Create or replace table {{new_record_table}} as
with incoming_first_record as ( -- select the first row for each record using last_modifed_date.
  select 
    {{pry_key}}, hashed_value 
  from  {{interday_table}}
  where row_number = 1
),
database_id_check as ( -- check database for the those records
  select 
    {{pry_key}}, hashed_value
  from {{history_table}}
  where valid_to_date = '9999-12-01' and {{pry_key}} in (select {{pry_key}} from incoming_first_record)  
),
database_hash_check as ( --Compare and select matching id and hash values 
  select 
   idic.{{pry_key}} as existing_id, idic.hashed_value as exsiting_hashed_value
  from database_id_check as idic
  inner join  incoming_first_record as ifr
    on idic.{{pry_key}} = ifr.{{pry_key}} and idic.hashed_value = ifr.hashed_value 
),
all_incoming_records as ( --Join exsiting records in database to incoming records
  select -- this step is not necessary, review and refactor it
    *
  from {{interday_table}} pic
  left join database_hash_check idhc
    on pic.{{pry_key}} = idhc.existing_id and pic.hashed_value = idhc.exsiting_hashed_value
  ),
new_records as ( --Filter out exsiting records
select 
 *
 , COALESCE(lag(date_sub(date({{modified_date}}), interval 1 day), 1) over(partition by {{pry_key}} order by {{modified_date}} desc), '1999-12-01') as valid_to_date
from all_incoming_records
where existing_id is null and exsiting_hashed_value is null
)
select --only new records selected
 * except(existing_id,exsiting_hashed_value, row_number)
from new_records
order by {{pry_key}}, {{modified_date}} desc;


{% endmacro %}
