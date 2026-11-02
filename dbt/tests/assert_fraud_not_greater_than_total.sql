select *
from {{ ref('mart_fraud_by_category') }}
where fraud_count > transaction_count or fraud_amount > total_amount
