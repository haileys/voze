class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :index, :home
      can :destroy, :session
      can :read, User
      can :manage, User, id: user.id
    else
      can :create, :session
    end
  end
end
