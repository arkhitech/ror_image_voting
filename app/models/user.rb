class User < ActiveRecord::Base
  has_many :media
  has_many :votes
  has_many :members
  has_many :user_groups
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
       
  mount_uploader :profile_picture, AvatarUploader
  # You likely have this before callback set up for the token.
  before_save :ensure_authentication_token
         
  def role?(r)
    # if role != nil
    # end
    false
  end
    
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        if registered_user.provider != auth.provider
          
          registered_user.provider = auth.provider
          registered_user.uid = auth.uid
          registered_user.remote_profile_picture_url = auth.info.image
          registered_user.save!
        end
        registered_user
      else
        user = User.new(name:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            password:Devise.friendly_token[0,20]                           
                          )
        user.remote_profile_picture_url = auth.info.image
        user.save!
        
        user
      end    
    end
  end
 
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end
 
  def reset_authentication_token
    self.authentication_token = generate_authentication_token
    self.save!
    self.authentication_token
  end
  
  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end 
end
