select *
from {{ ref('mart_customer_risk_profile') }}
where first_transaction_time > last_transaction_time
