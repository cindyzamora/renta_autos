class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :tipo
      t.string :marca
      t.integer :modelo
      t.string :linea
      t.integer :capacidad
      t.string :cc
      t.string :color

      t.timestamps
    end
  end
end
