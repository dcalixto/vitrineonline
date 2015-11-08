class CreateAnnouncements < ActiveRecord::Migration
  def self.up
    create_table :announcements do |t|
      t.text :body
      t.timestamps
      t.integer :vitrine_id
    end
      add_index :announcements, :vitrine_id
  end

  def self.down
    drop_table :announcements
  end
end
