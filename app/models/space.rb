class Space < ActiveRecord::Base
	self.inheritance_column = :_type_disabled # using a name of column "type" in table
end
