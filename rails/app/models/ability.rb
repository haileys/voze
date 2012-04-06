class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :index, :home
      can :destroy, :user_session
    else
      can :create, :user_session
    end
  end
end
