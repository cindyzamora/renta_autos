class AddCantidadToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :cantidad, :integer
  end
end
