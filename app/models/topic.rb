class Topic < ApplicationRecord
  has_many :ticket_topics, dependent: :destroy
  has_many :tickets, through: :ticket_topics

  validates :name, presence: true, uniqueness: true
end
