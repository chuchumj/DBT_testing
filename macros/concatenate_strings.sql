{% macro concatenate_strings(column_name, surfix) %}
    {{ column_name ~ '_' ~ surfix }} 
{% endmacro %}