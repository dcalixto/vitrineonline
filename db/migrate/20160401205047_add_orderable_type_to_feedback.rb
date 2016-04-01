class AddOrderableTypeToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :orderable_type, :string
  end
end
