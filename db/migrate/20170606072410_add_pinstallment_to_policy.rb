class AddPinstallmentToPolicy < ActiveRecord::Migration
  def change
    add_column :policies, :pinstallment, :integer
  end
end
