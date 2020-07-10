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
  has_many :ticket_topics
  has_many :topics, through: :ticket_topics
  accepts_nested_attributes_for :topics

  validates :title, :description, :submitter, presence: true

  def topics_attributes=(attributes)
    attributes.values.each do |topic_params|
      if topic_params[:name].present?
        topic = Topic.find_or_create_by(topic_params)
        ticket_topics.build(topic: topic) unless topics.include?(topic)
      end
    end
  end

  def self.public
    where(public: true)
  end
end
