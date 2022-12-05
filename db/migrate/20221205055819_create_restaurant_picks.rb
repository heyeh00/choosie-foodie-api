class CreateRestaurantPicks < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurant_picks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.references :event_restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
