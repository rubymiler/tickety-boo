class Meeting < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requestee, class_name: 'User'
  belongs_to :ticket

  validates :start_time, :end_time, :requester, :ticket, presence: true
  validate :start_time_after_now, :end_time_after_start_time

  def start_time_after_now
    return if start_time.blank?

    errors.add(:start_time, 'must be in the future') if start_time < DateTime.now
  end

  def end_time_after_start_time
    return if start_time.blank? || end_time.blank?

    errors.add(:end_time, 'must be after start time') if end_time < start_time
  end
end
