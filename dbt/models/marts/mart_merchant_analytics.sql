select
    merch,
    count() as transaction_count,
    uniqExact(customer_id) as unique_customers,
    countIf(is_fraud) as fraud_count,
    {{ safe_rate('countIf(is_fraud)', 'count()') }} as fraud_rate,
    sum(amount) as turnover,
    avg(amount) as average_amount,
    sumIf(amount, is_fraud) as fraud_amount,
    fraud_rate >= 10 and transaction_count >= 5 as is_suspicious
from {{ ref('stg_transactions') }}
group by merch
