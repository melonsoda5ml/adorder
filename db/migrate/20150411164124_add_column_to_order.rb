class AddColumnToOrder < ActiveRecord::Migration
  def change
		add_column :orders, :start_date, :date
		add_column :orders, :end_date, :date
		add_column :orders, :management_number, :string
  end
end
