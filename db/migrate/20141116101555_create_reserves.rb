class CreateReserves < ActiveRecord::Migration
  def change
    create_table :reserves do |t|
      t.references :agency, index: true
      t.string :productos
      t.decimal :monto, :precision => 5, :scale => 2, :default => 0.00
      t.date :fecha_inicio
      t.date :fecha_fin

      t.timestamps
    end
  end
end
