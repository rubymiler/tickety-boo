# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.manager?
      can :manage, :all
    elsif user.agent?
      can %i[read toggle_status], Ticket
      can :create, Comment
      can :manage, Comment, commenter_id: user.id
      can %i[create read], Post
      can :manage, Post, user_id: user.id
    else
      can :create, Ticket
      can %i[read update destroy toggle_status], Ticket, submitter_id: user.id
      can :create, Comment
      can :manage, Comment, commenter_id: user.id
      can :read, Post
    end
  end
end
