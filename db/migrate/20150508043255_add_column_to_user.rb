class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :division, :string
		add_column :users, :sales_id, :integer
		add_column :users, :manager_id, :integer
		add_column :users, :operation_id, :integer
  end
end
