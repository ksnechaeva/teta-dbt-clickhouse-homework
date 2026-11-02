#!/usr/bin/env ruby

require "csv"

abort("Usage: select_source_columns.rb /path/to/train.csv") unless ARGV.length == 1

fields = %w[
  transaction_time merch cat_id amount name_1 name_2 gender us_state lat lon
  merchant_lat merchant_lon target
]

output = CSV.new($stdout)
CSV.foreach(ARGV.fetch(0), headers: true) do |row|
  timestamp = row["transaction_time"]
  row["transaction_time"] = "#{timestamp}:00" if timestamp&.match?(/\d{2}:\d{2}\z/)
  output << fields.map { |field| row[field] }
end
