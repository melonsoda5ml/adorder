class Case < ActiveRecord::Base
	belongs_to :user
	has_many :orders, foreign_key: 'case_id'
	
	#case status
	OK_SCHEME = 0
	ALMOST_SCHEME = 1
	PROPOSING_SCHEME = 2

end
