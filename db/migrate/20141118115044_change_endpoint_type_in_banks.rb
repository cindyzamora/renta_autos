class ChangeEndpointTypeInBanks < ActiveRecord::Migration
  def change
  	change_column :banks, :endpoint, :string
  end
end
