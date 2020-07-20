class Meeting < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requestee, class_name: 'User'
  belongs_to :ticket

  validates :start_time, :end_time, :requester, :ticket, presence: true
end
