class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :index, :home
      can :destroy, :session
    else
      can :create, :session
    end
  end
end
