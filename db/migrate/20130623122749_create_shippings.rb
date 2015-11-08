class CreateShippings < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
      t.string :kind
      t.timestamps
    end
  end
end
