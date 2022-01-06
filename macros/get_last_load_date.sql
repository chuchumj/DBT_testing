{# this template can be used to get metadata details for loading #}

{% macro get_last_load_date( item ) %}
    max({{item}})
{% endmacro %}