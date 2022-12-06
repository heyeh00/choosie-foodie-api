class AddCuisineToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :cuisines, :text, array: true, default: []
  end
end
