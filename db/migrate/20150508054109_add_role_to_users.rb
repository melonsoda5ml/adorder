class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
		remove_column :users, :sales, :integer
		remove_column :users, :manager, :integer
		remove_column :users, :operation, :integer
  end
end
