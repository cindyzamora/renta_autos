class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :agency, index: true
      t.integer :account

      t.timestamps
    end
  end
end
