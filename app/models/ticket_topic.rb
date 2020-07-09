class TicketTopic < ApplicationRecord
  belongs_to :ticket
  belongs_to :topic
end
