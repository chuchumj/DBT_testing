{#  if it’s a string then format. Removes widespace, trims and make it lowercase #}

{% macro format_string_columns( string_column ) %}
COALESCE(TRIM(lower(string_column), '')) AS autorenew_off_reason
{% endmacro %}