class ChangeColumnSpace < ActiveRecord::Migration
  def change
		rename_column :spaces, :type, :category
  end
end
