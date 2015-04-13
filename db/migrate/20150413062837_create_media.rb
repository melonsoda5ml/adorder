class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
			t.integer :type
			t.string :symbol
			t.string :name
      t.timestamps null: false
    end
  end
end
