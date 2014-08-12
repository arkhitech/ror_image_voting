class Medium < ActiveRecord::Base
  acts_as_commentable
  acts_as_votable
  
  belongs_to :user, counter_cache: true
  belongs_to :admin_user
  
  has_many :group_shares
  has_many :slammables, foreign_key: 'medium_first_id'
  has_many :slams, class_name: 'Slam', foreign_key: 'medium_second_id'
  mount_uploader :picture, AvatarUploader
  
  def likes_count    
    self.get_likes.size
  end
  
end
