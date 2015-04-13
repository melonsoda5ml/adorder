#! ruby
require 'csv'

CSV.foreach("config/csv_data/mag.csv") do |row|
	media = Medium.create(
		:type=>0,
		:sign=>row[0],
		:name=>row[1],
	)
end

CSV.foreach("config/csv_data/web.csv") do |row|
	media = Medium.create(
		:type=>0,
		:sign=>row[0],
		:name=>row[1],
	)
end
