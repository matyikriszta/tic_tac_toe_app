class Ability
  include CanCan::Ability

  def initialize(player)
    player ||= Player.new
    if player.role?(:admin)
      can :manage, :all
    elsif player.role?(:registered)
      can :read, :all 
      can [:new, :create, :update, :edit, :show, :destroy, :make_move], Game
      can [:new, :create, :update, :edit, :show], Move
      can [:new, :create, :update, :edit, :show], Player, :id => player.id
    else
      can :read, :all
      can :create, Player
    end
  end
end