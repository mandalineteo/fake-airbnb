class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.string :name
      t.text :details
      t.text :location
      t.integer :max_guests
      t.decimal :price_per_night

      t.timestamps
    end
  end
end
