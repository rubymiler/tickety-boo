# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.manager?
      can :manage, :all
    elsif user.agent?
      can %i[read toggle_resolve toggle_public], Ticket
      can :create, Comment
      can :manage, Comment, commenter_id: user.id
    else
      can :create, [Ticket, Comment]
      can :read, Ticket, public: true
      can %i[read update destroy toggle_resolve], Ticket, submitter_id: user.id
      can :manage, Comment, commenter_id: user.id
    end
  end
end
