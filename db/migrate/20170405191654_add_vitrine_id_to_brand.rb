class AddVitrineIdToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :vitrine_id, :integer
  end
end
