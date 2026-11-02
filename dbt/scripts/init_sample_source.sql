CREATE DATABASE IF NOT EXISTS transactions_db;
CREATE DATABASE IF NOT EXISTS analytics;

CREATE TABLE transactions_db.transactions
(
    transaction_time DateTime,
    merch String,
    cat_id String,
    amount Float64,
    name_1 String,
    name_2 String,
    gender String,
    us_state String,
    lat Float64,
    lon Float64,
    merchant_lat Float64,
    merchant_lon Float64,
    target UInt8
)
ENGINE = MergeTree
ORDER BY transaction_time;

INSERT INTO transactions_db.transactions VALUES
('2026-01-05 08:15:00', 'Fresh Market', 'groceries', 42.50, 'Ada', 'Lovelace', 'F', 'CA', 34.0522, -118.2437, 34.0500, -118.2500, 0),
('2026-01-05 09:30:00', 'Tech World', 'electronics', 1250.00, 'Ada', 'Lovelace', 'F', 'CA', 34.0522, -118.2437, 34.1000, -118.2000, 1),
('2026-01-06 22:10:00', 'Night Fuel', 'gas', 75.20, 'Ada', 'Lovelace', 'F', 'CA', 34.0522, -118.2437, 34.0600, -118.2400, 1),
('2026-01-07 23:40:00', 'Luxury Shop', 'shopping', 2400.00, 'Ada', 'Lovelace', 'F', 'CA', 34.0522, -118.2437, 34.0700, -118.2300, 1),
('2026-01-05 12:00:00', 'Fresh Market', 'groceries', 85.00, 'Grace', 'Hopper', 'F', 'NY', 40.7128, -74.0060, 40.7100, -74.0100, 0),
('2026-01-06 13:20:00', 'City Cafe', 'food', 28.75, 'Grace', 'Hopper', 'F', 'NY', 40.7128, -74.0060, 40.7200, -74.0000, 0),
('2026-01-07 14:45:00', 'Tech World', 'electronics', 799.99, 'Grace', 'Hopper', 'F', 'NY', 40.7128, -74.0060, 40.7300, -73.9900, 0),
('2026-01-08 02:05:00', 'Online Deals', 'shopping', 999.00, 'Grace', 'Hopper', 'F', 'NY', 40.7128, -74.0060, 41.0000, -73.8000, 1),
('2026-01-05 17:10:00', 'City Cafe', 'food', 18.40, 'Alan', 'Turing', 'M', 'TX', 29.7604, -95.3698, 29.7500, -95.3600, 0),
('2026-01-06 18:30:00', 'Book Store', 'books', 55.00, 'Alan', 'Turing', 'M', 'TX', 29.7604, -95.3698, 29.7700, -95.3700, 0),
('2026-01-07 19:00:00', 'Night Fuel', 'gas', 62.10, 'Alan', 'Turing', 'M', 'TX', 29.7604, -95.3698, 29.7800, -95.3500, 0),
('2026-01-08 20:15:00', 'Air Travel', 'travel', 650.00, 'Alan', 'Turing', 'M', 'TX', 29.7604, -95.3698, 29.9000, -95.2000, 0),
('2026-01-09 03:25:00', 'Online Deals', 'shopping', 1500.00, 'Katherine', 'Johnson', 'F', 'FL', 25.7617, -80.1918, 25.8000, -80.2000, 1),
('2026-01-09 04:35:00', 'Online Deals', 'shopping', 1750.00, 'Katherine', 'Johnson', 'F', 'FL', 25.7617, -80.1918, 25.8000, -80.2000, 1),
('2026-01-09 05:45:00', 'Luxury Shop', 'shopping', 2200.00, 'Katherine', 'Johnson', 'F', 'FL', 25.7617, -80.1918, 25.7900, -80.2100, 1),
('2026-01-10 11:15:00', 'Fresh Market', 'groceries', 110.00, 'Katherine', 'Johnson', 'F', 'FL', 25.7617, -80.1918, 25.7700, -80.1900, 0),
('2026-01-10 15:00:00', 'Health Plus', 'health', 180.00, 'Edsger', 'Dijkstra', 'M', 'WA', 47.6062, -122.3321, 47.6100, -122.3300, 0),
('2026-01-10 16:30:00', 'Book Store', 'books', 35.50, 'Edsger', 'Dijkstra', 'M', 'WA', 47.6062, -122.3321, 47.6200, -122.3200, 0),
('2026-01-11 10:10:00', 'Air Travel', 'travel', 820.00, 'Edsger', 'Dijkstra', 'M', 'WA', 47.6062, -122.3321, 47.4500, -122.3000, 0),
('2026-01-11 21:55:00', 'Tech World', 'electronics', 1350.00, 'Edsger', 'Dijkstra', 'M', 'WA', 47.6062, -122.3321, 47.6300, -122.3100, 1);
