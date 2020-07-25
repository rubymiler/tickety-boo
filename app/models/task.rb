class Task < ApplicationRecord
  belongs_to :assigner, class_name: 'User'
  belongs_to :assignee, class_name: 'User'
  belongs_to :ticket

  validates :description, :assigner, :assignee, presence: true
end
