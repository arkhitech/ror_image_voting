class GroupShare < ActiveRecord::Base
  belongs_to :user_group
  belongs_to :medium
end
