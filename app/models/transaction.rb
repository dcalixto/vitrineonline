class Transaction < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :order # , :touch => true

  #belongs_to :user # , :touch => true


  attr_accessible :store_fee, :transaction_id, :status

  scope :stats, ->(date_range) { select('DATE(transactions.created_at) as day, count(*) as count').group('DATE(transactions.created_at)').where(created_at: date_range) }
  scope :products_stats, ->(date_range) { select('p.id as product_id, count(*) as tcount').joins(:order).joins('INNER JOIN product_data p on(p.id = orders.product_id)').where(created_at: date_range).group('p.id').order('tcount desc') }
  scope :product_stats, ->(product_id, date_range) { select('DATE(transactions.created_at) as day, count(*) as pcount').joins(:order).joins('INNER JOIN product_data p on(p.id = orders.product_id)').where(created_at: date_range).group('DATE(transactions.created_at)').where('p.id = ?', product_id) }
end
