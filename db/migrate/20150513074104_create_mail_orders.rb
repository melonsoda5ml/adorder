class CreateMailOrders < ActiveRecord::Migration
  def change
    create_table :mail_orders do |t|
			t.integer :order_id
			t.date :send_date
			t.string :space

      t.timestamps null: false
    end
  end
end
