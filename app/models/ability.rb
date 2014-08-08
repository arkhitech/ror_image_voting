class Ability
  include CanCan::Ability
 
  def initialize(user)
    user ||= AdminUser.new # guest user (not logged in)
    if user.role? :superadmin
        can :manage, :all
    end
    if user.role? :advertiser
      can :read, ActiveAdmin::Page, :name => "Dashboard"
      can :manage, Slam
    else
      can [:manage], UserGroup, user_id: user.id
      can [:manage], Medium, user_id: user.id
      can :read, :all
      #can :read, Device, user_id: user.id

    end
  end
end
