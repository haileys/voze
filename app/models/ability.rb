class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :index, :home
      can [:show, :destroy], :session
      can :read, User
      can :edit, User, id: user.id
      can :announce, :announces
      can [:read, :create], [Torrent, Version]
      can :edit, Version, user_id: user.id
    else
      can :create, :session
      can :create, User
    end
  end
end
