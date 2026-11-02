## Что реализовано

- [x] Source `transactions_db.transactions` и staging
- [x] 6 витрин
- [x] Собственные макросы `amount_bucket`, `safe_rate`
- [x] `dbt_utils`, `dbt_date`, `dbt_expectations`
- [x] Generic, singular и dbt 1.8+ unit tests
- [x] SQLFluff, pre-commit, Makefile

## Версии

- dbt-core: `1.8.9`
- dbt-clickhouse: `1.8.9`

## Проверки

- [x] `make lint`
- [x] `make seed`
- [x] `make run`
- [x] `make test`
- [x] `make docs`

### Лог dbt test

```text
ClickHouse 24.8.14.39
Source rows: 786431
dbt seed: PASS=1 WARN=0 ERROR=0 SKIP=0 TOTAL=1
dbt run:  PASS=7 WARN=0 ERROR=0 SKIP=0 TOTAL=7
dbt test: PASS=54 WARN=0 ERROR=0 SKIP=0 TOTAL=54
sqlfluff lint models tests macros: PASS
pre-commit run --all-files: PASS
dbt docs generate: PASS
```

### DAG / dbt Docs

![dbt lineage DAG](https://github.com/ksnechaeva/teta-dbt-clickhouse-homework/blob/feature/dbt-clickhouse-fraud/dbt/docs/dbt_dag.png?raw=true)

Документация воспроизводится командой `make docs`; PNG DAG хранится в `docs/dbt_dag.png`.

## Витрины

1. `mart_daily_state_metrics`
2. `mart_fraud_by_category`
3. `mart_fraud_by_state`
4. `mart_customer_risk_profile`
5. `mart_hourly_fraud_pattern`
6. `mart_merchant_analytics`

## Ограничения

- `customer_id` — surrogate key, поскольку исходная схема не содержит идентификатора клиента.
- Интеграционный прогон выполнен на ClickHouse 24.8.14.39 и полном размеченном `train.csv`.
