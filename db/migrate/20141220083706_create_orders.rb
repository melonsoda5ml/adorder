class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
			t.string :media
			t.date :release_date
			t.string :client
			t.string :agent
			t.string :space
			t.integer :price
			t.integer :rate
			t.string :account
			t.string :sample

      t.timestamps null: false
    end
  end
end
