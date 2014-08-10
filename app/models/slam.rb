class Slam < ActiveRecord::Base
  #belongs_to :medium_first
  #belongs_to :medium_second
  belongs_to :medium_first, class_name: "Medium"
  belongs_to :medium_second, class_name: "Medium"
  has_many :votes
  
  accepts_nested_attributes_for :medium_first, :medium_second
  def score
    "#{'%.2f' % (rand*100)}%"
  end
end
