# == Schema Information
#
# Table name: meetings
#
#  id           :integer          not null, primary key
#  start_time   :datetime
#  end_time     :datetime
#  ticket_id    :integer          not null
#  requester_id :integer
#  requestee_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  accepted     :boolean          default(FALSE)
#
class Meeting < ApplicationRecord
  enum status: { sent: 0, accepted: 1, declined: 2 }

  belongs_to :requester, class_name: 'User'
  belongs_to :requestee, class_name: 'User'
  belongs_to :ticket

  validates :start_time, :end_time, :requester, :requestee, :ticket, presence: true
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
