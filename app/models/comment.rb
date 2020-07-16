# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  ticket_id  :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Comment < ApplicationRecord
  belongs_to :commented_ticket, class_name: 'Ticket'
  belongs_to :commenter, class_name: 'User'

  # validates :body, presence: true
end
