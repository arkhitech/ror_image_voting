class Slam < ActiveRecord::Base
  belongs_to :media_first, class_name: 'Media'
  belongs_to :media_second, class_name: 'Media'
  
  has_many :votes
  
  accepts_nested_attributes_for :media_first, :media_second
end
