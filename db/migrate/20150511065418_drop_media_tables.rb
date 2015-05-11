class DropMediaTables < ActiveRecord::Migration
  def change
		drop_table :media
		drop_table :medium
  end
end
