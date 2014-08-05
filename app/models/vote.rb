class Votes < ActiveRecord::Base
  belongs_to :user
  belongs_to :slam
end
