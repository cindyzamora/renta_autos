class AddRawResponseToReserves < ActiveRecord::Migration
  def change
    add_column :reserves, :raw_response, :text
  end
end
