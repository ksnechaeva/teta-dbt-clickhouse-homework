# Integration run report

Дата прогона: 2026-11-02 (Europe/Moscow).

## Среда

- ClickHouse: `24.8.14.39`, Docker container `dbt-clickhouse`;
- dbt-core: `1.8.9`;
- dbt-clickhouse: `1.8.9`;
- source: 786 431 размеченная транзакция из `train.csv`;
- период данных: 2019-01-01 00:00:00 - 2020-03-10 16:08:00;
- классы: 781 927 обычных и 4 504 фродовых операций (fraud rate 0,5727%);
- при импорте отброшены дополнительные адресные поля, отсутствующие в схеме PDF;
- время `YYYY-MM-DD HH:MM` нормализовано до ClickHouse DateTime добавлением `:00`.

## Результаты

```text
dbt debug: PASS (All checks passed)
dbt seed:  PASS=1 WARN=0 ERROR=0 SKIP=0 TOTAL=1
dbt run:   PASS=7 WARN=0 ERROR=0 SKIP=0 TOTAL=7
dbt test:  PASS=54 WARN=0 ERROR=0 SKIP=0 TOTAL=54
dbt docs generate: PASS, catalog.json generated
sqlfluff lint models tests macros: PASS
pre-commit run --all-files: PASS
```

Состав `dbt test`: 52 data tests (generic + singular) и 2 unit tests dbt 1.8+.

## Созданные отношения

| Relation | Rows |
|---|---:|
| `mart_customer_risk_profile` | 963 |
| `mart_daily_state_metrics` | 21 386 |
| `mart_fraud_by_category` | 14 |
| `mart_fraud_by_state` | 51 |
| `mart_hourly_fraud_pattern` | 168 |
| `mart_merchant_analytics` | 693 |
| `stg_transactions` | view over 786 431 source rows |

dbt Docs воспроизводятся командой `make docs`; PNG DAG сохранён в `docs/dbt_dag.png`.
