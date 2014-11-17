class CreateAgencies < ActiveRecord::Migration
  def change
    create_table :agencies do |t|
      t.string :codigo
      t.string :nombre
      t.integer :endpoint

      t.timestamps
    end
  end
end
