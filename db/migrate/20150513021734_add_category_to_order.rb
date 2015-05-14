class AddCategoryToOrder < ActiveRecord::Migration
  def change
		add_column :orders, :category, :integer
  end
end
