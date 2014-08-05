class GroupShare < ActiveRecord::Base
  belongs_to :group
  belongs_to :media
  
    accepts_nested_attributes_for :group
      accepts_nested_attributes_for :media
end
