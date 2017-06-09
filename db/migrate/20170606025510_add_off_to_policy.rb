class AddOffToPolicy < ActiveRecord::Migration
  def change
    add_column :policies, :off, :integer
  end
end
