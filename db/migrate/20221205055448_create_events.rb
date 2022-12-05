class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.string :event_name
      t.datetime :datetime
      t.integer :price_min
      t.integer :price_max

      t.timestamps
    end
  end
end
