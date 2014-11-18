class ChangeColumnsNamesReserves < ActiveRecord::Migration
  def change
  	rename_column :reserves, :nombre, :cliente_nombre
  	rename_column :reserves, :dpi, :cliente_dpi
  	rename_column :reserves, :telefono, :cliente_telefono
  	rename_column :reserves, :no_tarjeta, :cliente_tarjeta
  	rename_column :reserves, :monto, :monto_total
  end
end
