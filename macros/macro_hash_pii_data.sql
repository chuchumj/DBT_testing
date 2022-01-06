{# Used to get the has of PII data fields #}

{% macro hash_pii_data( item ) %}
    MD5({{item}})
{% endmacro %}