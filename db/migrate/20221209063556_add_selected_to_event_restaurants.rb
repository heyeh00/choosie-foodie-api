class AddSelectedToEventRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_column :event_restaurants, :selected, :boolean, default: false
  end
end
