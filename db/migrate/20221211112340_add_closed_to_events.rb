class AddClosedToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :closed, :boolean, default: false
  end
end
