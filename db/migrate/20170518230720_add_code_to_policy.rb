class AddCodeToPolicy < ActiveRecord::Migration
  def change
    add_column :policies, :code, :string
  end
end
