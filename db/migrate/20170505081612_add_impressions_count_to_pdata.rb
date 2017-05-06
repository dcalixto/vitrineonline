class AddImpressionsCountToPdata < ActiveRecord::Migration
  def change
    add_column :pdata, :impressions_count, :integer
  end
end
