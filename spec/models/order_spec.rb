require 'rails_helper'

=begin
RSpec.describe Order, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
=end

describe Order do
	describe '
		context 'order information is not found' do
			it 'invalid' do
				order_params = null
				order = Order.new(order_params)
				order.valid?
				expect(order.errors).to be_present
			end
		end
	end
end
