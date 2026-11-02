select
    day_of_week_number,
    day_of_week_name,
    transaction_hour,
    count() as transaction_count,
    countIf(is_fraud) as fraud_count,
    {{ safe_rate('countIf(is_fraud)', 'count()') }} as fraud_rate,
    sum(amount) as total_amount,
    fraud_rate >= 10 as is_high_risk_window
from {{ ref('stg_transactions') }}
group by day_of_week_number, day_of_week_name, transaction_hour
