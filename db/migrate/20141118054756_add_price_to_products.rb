class AddPriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :price, :decimal, :precision => 5, :scale => 2, :default => 0.00
  end
end
