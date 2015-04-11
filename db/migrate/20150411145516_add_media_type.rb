class AddMediaType < ActiveRecord::Migration
  def change
		add_column :orders, :type, :integer
  end
end
