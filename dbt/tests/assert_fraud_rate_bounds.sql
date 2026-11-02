select 'category' as mart_name, fraud_rate
from {{ ref('mart_fraud_by_category') }}
where fraud_rate < 0 or fraud_rate > 100

union all

select 'state' as mart_name, fraud_rate
from {{ ref('mart_fraud_by_state') }}
where fraud_rate < 0 or fraud_rate > 100

union all

select 'customer' as mart_name, fraud_rate
from {{ ref('mart_customer_risk_profile') }}
where fraud_rate < 0 or fraud_rate > 100

union all

select 'hourly' as mart_name, fraud_rate
from {{ ref('mart_hourly_fraud_pattern') }}
where fraud_rate < 0 or fraud_rate > 100

union all

select 'merchant' as mart_name, fraud_rate
from {{ ref('mart_merchant_analytics') }}
where fraud_rate < 0 or fraud_rate > 100
