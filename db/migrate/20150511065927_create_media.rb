class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
			t.integer :category
			t.string :shorten
			t.string :name
      t.timestamps null: false
    end
  end
end
