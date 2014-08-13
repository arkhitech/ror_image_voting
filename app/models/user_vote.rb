class UserVote < ActiveRecord::Base
  belongs_to :user
  belongs_to :slam
  
  validates :slam, uniqueness: {scope: :user, message: 'already voted once'}
  validate :self_voting
  
  def self_voting
    errors.add(:user_id, "Cannot vote to the slam that includes their picture") if (user_id == slam.medium_first.user_id) or (user_id == slam.medium_second.user_id)
  end
end
