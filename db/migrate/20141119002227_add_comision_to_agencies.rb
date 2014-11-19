class AddComisionToAgencies < ActiveRecord::Migration
  def change
    add_column :agencies, :comision, :integer
  end
end
