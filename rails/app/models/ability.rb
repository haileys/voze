class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :index, :home
      can :destroy, UserSession
    else
      can :create, UserSession
    end
  end
end
