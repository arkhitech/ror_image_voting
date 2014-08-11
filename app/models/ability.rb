class Ability
  include CanCan::Ability
 
  def initialize(user)
      puts "#{'*'*80}\nAllowing to manage all\n#{'*'*80}"
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
      can [:manage], Slam#, medium_first: {user_id: user.id}
      can [:manage], Member, user_group: {user_id: user.id}
      can [:manage], Vote
      can [:manage], Follower
      can [:manage], Comment
      #can :manage, Member
      can :read, :all
      #can :read, Device, user_id: user.id

    end
  end
end
