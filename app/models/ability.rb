# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.manager?
      can :manage, :all
    elsif user.agent?
      can %i[read toggle_resolve toggle_public faq public_show pending resolved], Ticket
      can :create, Comment
      can :manage, Comment, commenter_id: user.id
    else
      can :create, [Ticket, Comment]
      can %i[read faq public_show], Ticket, public: true
      can %i[read update destroy toggle_resolve pending resolved], Ticket, submitter_id: user.id
      can :manage, Comment, commenter_id: user.id
    end
  end
end
