class AddSlugToEletronic < ActiveRecord::Migration
  def change
    add_column :eletronics, :slug, :string
  end
end
