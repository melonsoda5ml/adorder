class DropTableMedia < ActiveRecord::Migration
  def change
		 drop_table :media
  end
end
