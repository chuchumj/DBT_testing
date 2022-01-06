--check if record exist in history table
Create or replace table `unity-it-datawarehouse-test.mj.new_records` as
with incoming_first_record as ( -- select the first row for each record using last_modifed_date.
  select 
    id, hashed_value 
  from `unity-it-datawarehouse-test.mj.process_interday_changes` 
  where row_number = 1
),
database_id_check as ( -- check database for the those records
  select 
    id, hashed_value
  from `unity-it-datawarehouse-test.mj.history_table`
  where valid_to_date = '9999-12-01' and id in (select id from incoming_first_record)  
),
database_hash_check as ( --Compare and select matching id and hash values 
  select 
   idic.id as existing_id, idic.hashed_value as exsiting_hashed_value
  from database_id_check as idic
  inner join  incoming_first_record as ifr
    on idic.id = ifr.id and idic.hashed_value = ifr.hashed_value 
),
all_incoming_records as ( --Join exsiting records in database to incoming records
  select -- this step is not necessary, review and refactor it
    *
  from `unity-it-datawarehouse-test.mj.process_interday_changes` pic
  left join database_hash_check idhc
    on pic.id = idhc.existing_id and pic.hashed_value = idhc.exsiting_hashed_value
  ),
new_records as ( --Filter out exsiting records
select 
 *
 , COALESCE(lag(date_sub(date(LastModifiedDate), interval 1 day), 1) over(partition by id order by LastModifiedDate desc), '1999-12-01') as valid_to_date
from all_incoming_records
where existing_id is null and exsiting_hashed_value is null
)
select --only new records selected
 * except(existing_id,exsiting_hashed_value, row_number)
from new_records
order by id, lastModifiedDate desc