class AddDetailsToReserves < ActiveRecord::Migration
  def change
    add_column :reserves, :status, :string
    add_column :reserves, :nombre, :string
    add_column :reserves, :dpi, :string
    add_column :reserves, :telefono, :string
    add_column :reserves, :no_tarjeta, :string
  end
end
