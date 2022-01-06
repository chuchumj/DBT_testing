{# Extracts the actual field names for each of the columns #}

{% macro extract_feild_name( item ) %}
   {{item}} as {{item}}
{% endmacro %}