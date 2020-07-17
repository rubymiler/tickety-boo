# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.manager?
      can :manage, :all
    elsif user.agent?
      can %i[read update], Ticket
      can :manage, Comment, commenter_id: user.id
    else
      can :create, Ticket
      can %i[read update destroy], Ticket, submitter_id: user.id
      
      can :manage, Comment, commenter_id: user.id
    end
  end
end
