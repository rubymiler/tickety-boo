# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.manager?
      can :manage, :all
    elsif user.agent?
      can %i[read toggle_resolve set_faq faq pending resolved public_show], Ticket
      can :create, %i[Comment Meeting Task]
      can :manage, Comment, commenter_id: user.id
      can :manage, Meeting, requester_id: user.id
      can :manage, Topic
      can :update, Task, assignee_id: user.id
      can :manage, Task, assigner_id: user.id
    else
      can :create, [Ticket, Comment]
      can %i[faq public_show], Ticket, public: true
      can %i[read update destroy toggle_resolve pending resolved], Ticket, submitter_id: user.id
      can :manage, Comment, commenter_id: user.id
      can %i[read accept decline], Meeting, requestee_id: user.id
      can :manage, Topic
    end
  end
end
