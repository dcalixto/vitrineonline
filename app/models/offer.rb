class Offer < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :reportable, polymorphic: true
 belongs_to :vitrine
 belongs_to :product
end
