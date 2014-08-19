class Slam < ActiveRecord::Base
  #belongs_to :medium_first
  #belongs_to :medium_second
  belongs_to :medium_first, class_name: "Medium", counter_cache: :slams_count
  belongs_to :medium_second, class_name: "Medium", counter_cache: :slammables_count
  has_many :user_votes, dependent: :destroy
  
  accepts_nested_attributes_for :medium_first, :medium_second
  
  validates :medium_first, uniqueness: {scope: :medium_second, message: "slam already exist"}
  
  validate :both_pictures_different
  
  def both_pictures_different
    if self.medium_first == self.medium_second
      errors.add(:medium_first, 'must be different from Medium second')
    end
  end
  
  def score
    #"#{'%.2f' % (rand*100)}%"
    pvote = self.user_votes.select{|p| p.vote_status == true}.count
    nvote = self.user_votes.select{|p| p.vote_status == false}.count
    total = pvote + nvote
    #score = ActionController::Base.helpers.number_to_percentage((pvote/total * 100), precision: 2)
    total > 0 ? "#{'%.2f' % (pvote.to_f/total *100)}%": '0%'
  end
end
