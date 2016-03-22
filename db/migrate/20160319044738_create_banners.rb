class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string   :img
      t.integer  :vitrine_id,                                                  :null => false
      t.timestamps
    end
      add_index :banners, :vitrine_id
  end
end
