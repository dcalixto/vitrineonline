class AddBannerToVitrine < ActiveRecord::Migration
  def change
    add_column :vitrines, :banner, :string
  end
end
