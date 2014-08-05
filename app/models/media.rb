class Media < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin_users
  
  has_many :group_shares
  
  mount_uploader :picture, AvatarUploader
end
