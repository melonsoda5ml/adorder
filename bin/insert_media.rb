# -*- encoding: utf-8 -*-
require "rubygems"
require 'csv'
require "active_record"

Medium.destroy_all

CSV.foreach("../media.csv", 'r:UTF-8') do |row|
	m = Medium.create(
		:category => row[0],
		:shorten => row[1],
		:name => row[2]
	)
end
