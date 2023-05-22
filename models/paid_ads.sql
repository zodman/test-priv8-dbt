{#TODO: change when big query changes #}
{% set postgres_map_fields = dict(string='varchar', int64='integer', date='date') %}
{% set remap_fields = var('remap_fields') %}


WITH paid_ads  AS (


    {% for channel in var('source_data') %}

        SELECT
            {% for column, type_ in get_mcdm_fields() %}

                {%if column in remap_fields[channel] %}

                    {{ remap_fields[channel][column] }}

                {% elif column in get_all_columns(channel) %}

                    CAST( {{column}} as {{postgres_map_fields.get(type_)}} ) 

                {% else %}
                    {%if type_ == 'string' %}
                        ''
                    {%elif type_ == 'int64' %}
                        0
                    {% endif %}
                {% endif %}

                as {{column}}

                {% if not loop.last %},{% endif %}

            {% endfor %}
        FROM 
            {{ source('source_data',channel) }}

        {% if not loop.last %}
        UNION
        {% endif %}
    {% endfor %}
)

SELECT *  FROM paid_ads
