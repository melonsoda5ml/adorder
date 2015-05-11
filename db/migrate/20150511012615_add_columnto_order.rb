class AddColumntoOrder < ActiveRecord::Migration
  def change
		add_column :orders, :case_id, :integer
  end
end
