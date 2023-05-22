{% macro get_mcdm_fields() %}
    {% set query_fields %}
        SELECT
            mcdm_field_name, mcdm_field_value_type
        FROM
            {{ source('source_defined_data','mcdm') }}
    {% endset %}
    {% set results = dbt_utils.get_query_results_as_dict(query_fields) %}
    {% set mcdm_fields = zip(results['mcdm_field_name'], results['mcdm_field_value_type'])|list %}
    {{ return(mcdm_fields) }}
{% endmacro %}
