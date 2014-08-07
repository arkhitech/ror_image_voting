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
      can :read, :all
      can :manage, UserGroup
    end
  end
end
