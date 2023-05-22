{% set remap_fields = var('remap_fields') %}

WITH paid_ads  AS (

    {% for channel in var('sources_list') -%}
         SELECT
            {% for column, type_ in get_mcdm_fields() -%}
                {% if column in remap_fields[channel] -%}
                    {{ remap_fields[channel][column] }}
                {% elif column in get_all_columns(channel) -%}
                    CAST( {{column}} AS {{type_}} ) 
                {% else -%}
                    {% if type_ == 'string' -%}
                        ''
                    {% elif type_ == 'int64' -%}
                        0
                    {% endif %}
                {% endif %} AS {{column}} {% if not loop.last %},{% endif %}
            {% endfor %}
        FROM 
            {{ source('source_data',channel) }}

        {% if not loop.last %}
        UNION ALL
        {% endif %}
    {%- endfor %}
)

SELECT *  FROM paid_ads
