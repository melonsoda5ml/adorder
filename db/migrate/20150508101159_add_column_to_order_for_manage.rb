class AddColumnToOrderForManage < ActiveRecord::Migration
  def change
    add_column :orders, :management_number, :string
  end
end
