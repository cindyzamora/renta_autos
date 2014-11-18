class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :nombre
      t.integer :code
      t.string :endpoint
      t.string :string

      t.timestamps
    end
  end
end
