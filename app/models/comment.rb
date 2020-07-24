# == Schema Information
#
# Table name: comments
#
#  id                  :integer          not null, primary key
#  body                :text
#  commented_ticket_id :integer
#  commenter_id        :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Comment < ApplicationRecord
  belongs_to :commented_ticket, class_name: 'Ticket'
  belongs_to :commenter, class_name: 'User'

  validates :body, presence: true, length: { in: 10..1000 }
end
