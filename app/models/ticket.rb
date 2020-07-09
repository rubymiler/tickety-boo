# == Schema Information
#
# Table name: tickets
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  public       :boolean
#  submitter_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Ticket < ApplicationRecord
  belongs_to :submitter, class_name: 'User'

  validates :title, :description, :submitter, presence: true

  def self.public
    where(public: true)
  end
end
