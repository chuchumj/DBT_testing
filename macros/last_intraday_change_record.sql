{ # {% macro get_last_intraday_change_record(table_columns) %}
    {% for field in table_columns %}
        {{field}} as {{field}}
    {% endfor %}
{% endmacro %} #}