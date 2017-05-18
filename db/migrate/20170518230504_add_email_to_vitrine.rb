class AddEmailToVitrine < ActiveRecord::Migration
  def change
    add_column :vitrines, :email, :string
  end
end
