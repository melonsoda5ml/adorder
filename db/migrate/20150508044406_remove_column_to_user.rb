class RemoveColumnToUser < ActiveRecord::Migration
  def change
		rename_column :users, :sales_id, :sales
		rename_column :users, :manager_id, :manager
		rename_column :users, :operation_id, :operation
  end
end
