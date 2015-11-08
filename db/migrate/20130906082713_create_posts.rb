class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :text
      t.string :image
      t.references :user

      t.timestamps
    end
  end
end
