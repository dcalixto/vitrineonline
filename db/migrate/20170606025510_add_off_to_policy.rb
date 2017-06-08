class AddOffToPolicy < ActiveRecord::Migration
  def change
    add_column :policies, :off, :string
  end
end
