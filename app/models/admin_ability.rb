class AdminAbility
  include CanCan::Ability

  def initialize(user)
    user ||= AdminUser.new

    # An administrator can manage the blog posts and manage users
    if user.role?('superadmin')
      can :manage, :all
    else
        can :read, :all
    end
  end
end