class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
			t.string "name"
			t.string "client"
			t.string "agent"
			t.integer "pic_id"
      t.timestamps null: false
    end
  end
end
