with source_data as (
    select *
    from {{ source('transactions_db', 'transactions') }}
),

typed as (
    select
        cast(transaction_time as DateTime) as transaction_time,
        cast(trim(merch) as String) as merch,
        cast(trim(cat_id) as String) as cat_id,
        cast(amount as Float64) as amount,
        cast(trim(name_1) as String) as name_1,
        cast(trim(name_2) as String) as name_2,
        cast(upper(trim(gender)) as String) as gender,
        cast(upper(trim(us_state)) as String) as us_state,
        cast(lat as Float64) as lat,
        cast(lon as Float64) as lon,
        cast(merchant_lat as Float64) as merchant_lat,
        cast(merchant_lon as Float64) as merchant_lon,
        cast(target as UInt8) as target
    from source_data
)

select
    {{ dbt_utils.generate_surrogate_key([
        'name_1', 'name_2', 'gender', 'us_state'
    ]) }} as customer_id,
    transaction_time,
    toDate(transaction_time) as transaction_date,
    toHour(transaction_time) as transaction_hour,
    {{ dbt_date.date_part('dayofweek', 'transaction_time') }} as day_of_week_number,
    arrayElement(
        ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
        toDayOfWeek(transaction_time)
    ) as day_of_week_name,
    merch,
    cat_id,
    amount,
    {{ amount_bucket('amount') }} as amount_bucket,
    name_1,
    name_2,
    gender,
    us_state,
    lat,
    lon,
    merchant_lat,
    merchant_lon,
    target,
    target = 1 as is_fraud
from typed
