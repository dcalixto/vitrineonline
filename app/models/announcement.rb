class Announcement < ActiveRecord::Base
  attr_accessible :title, :body
  # belongs_to :boutique
  belongs_to :vitrine
  def self.current
    order('created_at desc').first || new
  end

  def exists?
    !new_record?
  end
end
