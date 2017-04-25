class AddUserIdToImpression < ActiveRecord::Migration
  def change
    add_column :impressions, :user_id, :integer
  end
end
