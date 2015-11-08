class View < ActiveRecord::Base
  attr_accessible :vitrine_id, :ip_address


  belongs_to :vitrine

  scope :stats, ->(date_range) { select('DATE(created_at) as day, count(*) as count').group('DATE(created_at)').where(created_at: date_range) }
end
