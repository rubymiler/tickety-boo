module CommentsHelper
  def show_answer_link(comment)
    if comment.commented_ticket.answer.blank?
      if (can? :update, comment) && !current_user.member?
        form_tag(ticket_comment_path(comment.commented_ticket, comment), method: :patch) do
          submit_tag 'Set as answer'
        end
      end
    end
  end
end
