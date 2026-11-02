{% macro safe_rate(numerator, denominator, scale=100.0) -%}
    if({{ denominator }} = 0, 0.0, {{ scale }} * {{ numerator }} / {{ denominator }})
{%- endmacro %}
