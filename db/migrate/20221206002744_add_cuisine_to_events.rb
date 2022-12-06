class AddCuisineToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :cuisine, :string
  end
end
