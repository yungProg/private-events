class AddVenueToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :venue, :string
  end
end
