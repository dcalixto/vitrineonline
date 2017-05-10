class AddStateToOdata < ActiveRecord::Migration
  def change
    add_column :odata, :vitrine_state, :string
  end
end
