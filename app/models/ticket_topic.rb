# == Schema Information
#
# Table name: ticket_topics
#
#  id         :integer          not null, primary key
#  ticket_id  :integer          not null
#  topic_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TicketTopic < ApplicationRecord
  belongs_to :ticket
  belongs_to :topic

  validates :ticket, :topic, presence: true
end
