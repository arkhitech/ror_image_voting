class Member < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_group
  
  validates :user_group, uniqueness: {scope: :user, message: 'You are already member of this group'}
end
