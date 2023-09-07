class ChangePriceDataTypeToFloat < ActiveRecord::Migration[7.0]
  def up
    change_column :listings, :price_per_night, :float
  end

  def down
    change_column :listings, :price_per_night, :decimal
  end
end
