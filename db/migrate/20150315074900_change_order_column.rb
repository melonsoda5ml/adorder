class ChangeOrderColumn < ActiveRecord::Migration
  def change
		add_column:orders, :margin, :integer
		add_column:orders, :production,   :string
		add_column:orders, :placement_report,   :boolean
		add_column:orders, :attribution_report,   :boolean
		add_column:orders, :download_pdf,   :boolean
		add_column:orders, :clickcount,   :boolean
		add_column:orders, :notes, :string
		add_column:orders, :person_in_charge,   :string
  end
end
