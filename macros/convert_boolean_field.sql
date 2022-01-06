{% macro convert_boolean_field( boolen_field) %}
    if ( {{boolen_field}} = 1, true, false ) 
{% endmacro %}