class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :cuisine
      t.string :phone_number
      t.string :image_url
      t.integer :ave_price
      t.integer :rating

      t.timestamps
    end
  end
end
