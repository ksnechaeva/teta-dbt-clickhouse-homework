select
    transaction_date,
    us_state,
    count() as transaction_count,
    sum(amount) as total_amount,
    avg(amount) as average_amount,
    quantileExact(0.95)(amount) as p95_amount, -- noqa: PRS
    {{ safe_rate("countIf(amount_bucket in ('LARGE', 'VERY_LARGE'))", 'count()') }}
        as large_transaction_rate
from {{ ref('stg_transactions') }}
group by transaction_date, us_state
