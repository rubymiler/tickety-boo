class Comment < ApplicationRecord
  belongs_to :commented_ticket, class_name: 'Ticket'
  belongs_to :commenter, class_name: 'User'

  validates :body, presence: true, length: { in: 10..1000 }
  validates :commented_ticket, presence: true
end
