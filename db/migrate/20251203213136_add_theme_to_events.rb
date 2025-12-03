class AddThemeToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :theme, :string
  end
end
