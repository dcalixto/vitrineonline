class AddInstallmentToPolicy < ActiveRecord::Migration
  def change
    add_column :policies, :installment, :string
  end
end
