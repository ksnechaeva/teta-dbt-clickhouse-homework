{% macro amount_bucket(amount_column) -%}
    multiIf(
        {{ amount_column }} < 50, 'SMALL',
        {{ amount_column }} < 200, 'MEDIUM',
        {{ amount_column }} < 1000, 'LARGE',
        'VERY_LARGE'
    )
{%- endmacro %}
