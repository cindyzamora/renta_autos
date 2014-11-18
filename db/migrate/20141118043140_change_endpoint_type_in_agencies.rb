class ChangeEndpointTypeInAgencies < ActiveRecord::Migration
  def change
  	change_column :agencies, :endpoint, :string
  end
end
