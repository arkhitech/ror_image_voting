class Medium < ActiveRecord::Base
  acts_as_commentable
  
  belongs_to :user
  belongs_to :admin_user
  
  has_many :group_shares
  has_many :slams, foreign_key: 'medium_first_id'
  has_many :slammables, class_name: 'Slam', foreign_key: 'medium_second_id'
  mount_uploader :picture, AvatarUploader
  
end
