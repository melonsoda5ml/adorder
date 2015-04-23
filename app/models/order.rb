class Order < ActiveRecord::Base
	belongs_to :user
	self.inheritance_column = :_type_disabled # using a name of column "type" in table
#	validates :user_id, presence: true
	attr_accessor :media_mag, :media_web
end
