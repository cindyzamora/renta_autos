class CreateCarritosAccounts < ActiveRecord::Migration
  def change
    create_table :carritos_accounts do |t|
      t.references :bank, index: true
      t.integer :account

      t.timestamps
    end
  end
end
