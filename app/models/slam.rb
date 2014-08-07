class Slam < ActiveRecord::Base
  #belongs_to :medium_first
  #belongs_to :medium_second
  belongs_to :medium_first, class_name: "Medium"
  belongs_to :medium_second, class_name: "Medium"
  
  accepts_nested_attributes_for :medium_first, :medium_second
end
