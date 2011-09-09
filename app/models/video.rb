class Video < ActiveRecord::Base
  validates_presence_of :uid
  
  # before_validation :generate_uid, :on => :create
  scope :is_published, where(:published => true)  
  
  def generate_uid
    self.uid = UUID.generate
  end
  
  def viewed!
    self.views += 1
    self.save!
  end
  
  def title
    self[:title] || "Recording #{self.created_at.strftime("%m/%d/%Y")}"
  end
end
