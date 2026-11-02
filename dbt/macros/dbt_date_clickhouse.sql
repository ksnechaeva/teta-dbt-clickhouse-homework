{% macro clickhouse__date_part(datepart, date) -%}
    {%- if datepart | lower in ['dayofweek', 'dow', 'isodow'] -%}
        toDayOfWeek({{ date }})
    {%- else -%}
        datePart('{{ datepart }}', {{ date }})
    {%- endif -%}
{%- endmacro %}
