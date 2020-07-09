class Topic < ApplicationRecord
  has_many :ticket_topics
  has_many :tickets, through: :ticket_topics
end
