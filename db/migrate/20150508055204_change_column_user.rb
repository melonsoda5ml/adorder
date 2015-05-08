class ChangeColumnUser < ActiveRecord::Migration
  def change
		change_column :users, :role, :integer, index:true
  end
end
