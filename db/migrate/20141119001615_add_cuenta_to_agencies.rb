class AddCuentaToAgencies < ActiveRecord::Migration
  def change
    add_column :agencies, :cuenta, :string
  end
end
