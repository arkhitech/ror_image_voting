class Group < ActiveRecord::Base
  belongs_to :user
  
  has_many :members
  has_many :groupshares
  
    accepts_nested_attributes_for :user
end
