class CreateProductAvailableForms < ActiveRecord::Migration
  def change
    create_table :product_available_forms do |t|
      t.string :nombre
      t.string :tipo
      t.boolean :requerido

      t.timestamps
    end
  end
end
