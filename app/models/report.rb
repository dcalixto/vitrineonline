class Report < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :reportable, polymorphic: true
 belongs_to :user
 
end
