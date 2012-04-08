class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :index, :home
      can :destroy, :session
      can :read, User
      can :edit, User, id: user.id
      can :announce, :announces
    else
      can :create, :session
      can :create, User
    end
  end
end
