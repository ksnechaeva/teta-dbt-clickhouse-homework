# dbt ClickHouse fraud analytics

Домашнее задание «Введение в dbt»: полный проект на ClickHouse с source, staging,
шестью аналитическими витринами, макросами, пакетами, generic/singular/unit tests,
SQLFluff, pre-commit, Makefile и dbt Docs.

Полный проект добавляется Pull Request из ветки `feature/dbt-clickhouse-fraud`
в каталог `dbt/`.

Проверено на ClickHouse 24.8.14.39 и полном размеченном `train.csv` из 786 431 строки:

- `dbt run`: PASS=7;
- `dbt test`: PASS=54;
- `sqlfluff lint`: PASS;
- `pre-commit run --all-files`: PASS.

В PR приложены лог проверок и скриншот lineage graph.
