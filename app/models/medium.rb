class Medium < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin_user
  
  has_many :group_shares
  has_many :slams
  mount_uploader :picture, AvatarUploader
  
end
