class Follower < ActiveRecord::Base
  belongs_to :user, class_name: "User"
  belongs_to :follower, class_name: "User"
  
  validates :user, uniqueness: {scope: :follower, message: 'already following this user'}
end
