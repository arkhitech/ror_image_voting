class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :slam
  
  validates :slam, uniqueness: {scope: :user, message: 'already voted once'}
end
