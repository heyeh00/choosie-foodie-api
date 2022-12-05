class CreateEventRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :event_restaurants do |t|
      t.references :event, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
