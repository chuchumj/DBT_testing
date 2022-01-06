{% set colmumn_list = ['item','JE_Code', 'Store', 'Country', 'Region', 'Date'] %} 

{{ config(materialized='table') }}


SELECT 
if ( {{concatenate_strings('JE', 'Code') }} = 'I-2261','invalid', 'valid') as validity, 
{% for columns in colmumn_list %}
{{columns}},
{% endfor %}
FROM {{ ref('item') }}
limit 10