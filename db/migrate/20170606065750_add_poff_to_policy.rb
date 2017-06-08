class AddPoffToPolicy < ActiveRecord::Migration
  def change
    add_column :policies, :poff, :integer
  end
end
