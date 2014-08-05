class User < ActiveRecord::Base
  has_many :medias
  has_many :votes
  has_many :members
  has_many :groups
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
end
