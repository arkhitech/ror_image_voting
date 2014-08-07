class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
       
  belongs_to :medium
       
  
  ROLES = %w(superadmin advertiser)
  
  def role?(r)
    role.include? r.to_s
  end
end
