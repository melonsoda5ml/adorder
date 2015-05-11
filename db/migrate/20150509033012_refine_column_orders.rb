class RefineColumnOrders < ActiveRecord::Migration
  def change
		change_column :cases, :status, :integer, :after=>:name
  end
end
