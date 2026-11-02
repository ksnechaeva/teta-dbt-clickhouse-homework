select
    cat_id,
    count() as transaction_count,
    countIf(is_fraud) as fraud_count,
    {{ safe_rate('countIf(is_fraud)', 'count()') }} as fraud_rate,
    sum(amount) as total_amount,
    sumIf(amount, is_fraud) as fraud_amount
from {{ ref('stg_transactions') }}
group by cat_id
