# ClickHouse Fraud Analytics — dbt project

Полноценный учебный dbt-проект на максимальную оценку по заданию «Введение в dbt».
Источник строго соответствует PDF: `transactions_db.transactions`; исходные имена и типы
зафиксированы в `models/sources/sources.yml`.

## Архитектура

```text
transactions_db.transactions (source)
                 |
                 v
        stg_transactions (view)
                 |
                 +--> mart_daily_state_metrics
                 +--> mart_fraud_by_category
                 +--> mart_fraud_by_state
                 +--> mart_customer_risk_profile
                 +--> mart_hourly_fraud_pattern
                 +--> mart_merchant_analytics
```

В исходнике нет `customer_id`. Staging создаёт детерминированный surrogate key из
`name_1`, `name_2`, `gender`, `us_state` через `dbt_utils.generate_surrogate_key`.
Это учебное приближение: однофамильцы с одинаковыми атрибутами будут объединены.

Пакеты используются так:

- `dbt_utils`: surrogate key и тесты уникальности комбинаций;
- `dbt_date`: извлечение дня недели в staging (timezone задан как UTC);
- `dbt_expectations`: проверки диапазонов часов, дней недели и процентов.

Собственные макросы: `amount_bucket` (сегментация суммы) и `safe_rate` (безопасный процент).
Также добавлен ClickHouse-dispatch `clickhouse__date_part`, поскольку ClickHouse 24.8 не
поддерживает сгенерированное пакетом имя функции `date_part` в нижнем регистре.

## Требования

- Python 3.10+;
- доступный ClickHouse с таблицей `transactions_db.transactions`;
- переменные подключения (значения ниже — defaults):

```bash
export CLICKHOUSE_HOST=localhost
export CLICKHOUSE_PORT=8123
export CLICKHOUSE_USER=default
export CLICKHOUSE_PASSWORD=''
export CLICKHOUSE_DATABASE=analytics
export CLICKHOUSE_SECURE=false
export CLICKHOUSE_VERIFY=true
```

`profiles.yml` хранится в проекте исключительно для воспроизводимости домашней работы и не
содержит секретов. Пароль передаётся только через окружение.

## Быстрый запуск

```bash
make install
make deps
make debug
make seed
make run
make test
make docs
```

Документация локально:

```bash
.venv/bin/dbt docs serve --profiles-dir .
```

Полный цикл: `make ci`. Unit tests отдельно: `make unit-test`. Линт: `make lint`.
Перед первым commit установите hooks: `.venv/bin/pre-commit install`.

## Тестовое покрытие

- source/staging: `not_null`, `accepted_values`, диапазоны;
- marts: `unique`, уникальные комбинации grain, диапазон fraud rate;
- singular: отрицательные суммы, границы fraud rate, согласованность fraud/total,
  порядок истории клиента;
- unit (dbt 1.8+): агрегация категории и HIGH-риск клиента.

## Проверка

Структура, YAML, ссылки `ref`/`source` и обязательные артефакты проверены. На локальном
ClickHouse 24.8.14.39 успешно выполнены `dbt debug`, `seed`, все 7 моделей, 54 теста,
`docs generate` и SQLFluff. Подробности находятся в `docs/integration_run.md`.

Финальный прогон выполнен на полном размеченном `train.csv`: 786 431 строк, 14 категорий,
781 927 обычных и 4 504 фродовых операции. CSV содержит дополнительные адресные поля;
при загрузке в `transactions_db.transactions` сохранены только 13 колонок из PDF.

Потоковая подготовка полного CSV воспроизводится скриптом
`scripts/select_source_columns.rb`: он отбирает поля PDF и добавляет секунды к DateTime.

Небольшой синтетический source для автономной демонстрации можно воспроизвести командой:

```bash
docker exec -i dbt-clickhouse clickhouse-client \
  --user dbt_user --password dbt_password --multiquery \
  < scripts/init_sample_source.sql
```

## Подготовка PR

1. Создайте ветку, например `feature/dbt-clickhouse-fraud`.
2. Выполните `make ci` на доступном ClickHouse.
3. При необходимости откройте `docs/dbt_dag.png` или пересоздайте снимок через dbt Docs.
4. Используйте заполненный `.github/pull_request_template.md` с настоящим логом и DAG.
5. Проверьте, что в commit не попали `.venv`, `target`, `logs`, `dbt_packages` или секреты.
