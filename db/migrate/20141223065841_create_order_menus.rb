class CreateOrderMenus < ActiveRecord::Migration
  def change
    create_table :order_menus do |t|
			t.string :media
			t.string :agent
			t.string :space
			t.integer :rate
			t.integer :status

      t.timestamps null: false
    end
  end
end
