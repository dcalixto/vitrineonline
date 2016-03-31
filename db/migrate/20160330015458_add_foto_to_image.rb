class AddFotoToImage < ActiveRecord::Migration
  def change
    add_column :images, :foto, :string
  end
end
