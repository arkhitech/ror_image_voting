class Follower < ActiveRecord::Base
  belongs_to :user, class_name: "User", counter_cache: :followers_count
  belongs_to :follower, class_name: "User", counter_cache: :following_count
  
  validates :user, uniqueness: {scope: :follower, message: 'already following this user'}
end
