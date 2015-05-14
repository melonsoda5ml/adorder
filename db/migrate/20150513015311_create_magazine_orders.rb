class CreateMagazineOrders < ActiveRecord::Migration
  def change
    create_table :magazine_orders do |t|
			t.integer "order_id"
			t.integer "issue"
			t.date "release_date"
			t.string "space"
			t.boolean "ad_form"#純広告orTU
			t.integer "production_costs"
			t.string   "production"
			t.integer "montgh_of_appropriation"#制作費計上月
      t.timestamps null: false
    end
  end
end
