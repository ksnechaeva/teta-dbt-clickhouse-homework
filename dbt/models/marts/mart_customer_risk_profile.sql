with customer_metrics as (
    select
        customer_id,
        any(name_1) as name_1,
        any(name_2) as name_2,
        any(gender) as gender,
        any(us_state) as us_state,
        min(transaction_time) as first_transaction_time,
        max(transaction_time) as last_transaction_time,
        count() as transaction_count,
        countIf(is_fraud) as fraud_count,
        {{ safe_rate('countIf(is_fraud)', 'count()') }} as fraud_rate,
        sum(amount) as total_amount,
        avg(amount) as average_amount
    from {{ ref('stg_transactions') }}
    group by customer_id
)

select
    *,
    multiIf(
        fraud_rate >= 20 or fraud_count >= 3, 'HIGH',
        fraud_rate >= 5 or fraud_count >= 1, 'MEDIUM',
        'LOW'
    ) as risk_level
from customer_metrics
