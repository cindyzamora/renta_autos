class AddCodigoToReserves < ActiveRecord::Migration
  def change
    add_column :reserves, :codigo, :string
  end
end
