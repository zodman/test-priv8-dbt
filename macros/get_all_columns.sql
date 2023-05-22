{% macro get_all_columns(channel) %}
    {% set all_columns = adapter.get_columns_in_relation(source("source_data",channel))|map(attribute='name')|list %}
    {{ return(all_columns)}}
{% endmacro %}
