class GroupShare < ActiveRecord::Base
  belongs_to :group
  belongs_to :media
end
