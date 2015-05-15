class Order < ActiveRecord::Base
	belongs_to :case
	has_many :magazine_orders, foreign_key: 'order_id'
	has_many :mail_orders, foreign_key: 'order_id'
	self.inheritance_column = :_type_disabled # using a name of column "type" in table
#	validates :user_id, presence: true
	attr_accessor :media_mag, :media_web, :media_mail

	#order category
	MAGAZINE_SCHEME = 0
	WEB_SCHEME = 1
	MAIL_SCHEME = 2
end
