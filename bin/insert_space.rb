# -*- encoding: utf-8 -*-
require "rubygems"
require 'csv'
require "active_record"

Space.destroy_all

CSV.foreach("../space.csv", 'r:UTF-8') do |row|
	s = Space.create(
		:category => row[0],
		:name => row[1]
	)
end
