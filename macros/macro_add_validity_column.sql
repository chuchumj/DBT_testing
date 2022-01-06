{% macro add_validity_column( validity_date, pry_key ) %}
    lag({{validity_date}}) over(PARTITION BY {{pry_key}} ORDER BY {{validity_date}} ASC) 
{% endmacro %}

