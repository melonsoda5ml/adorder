class Case < ActiveRecord::Base
	belongs_to :user
	has_many :orders, foreign_key: 'case_id'
end
