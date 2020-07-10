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

  has_many :ticket_topics, dependent: :destroy
  has_many :topics, through: :ticket_topics

  has_many :comments, dependent: :destroy
  has_many :commenters, through: :comments, class_name: 'User'

  validates :title, :description, :submitter, presence: true

  def topics_attributes=(attributes)
    attributes.values.each do |topic_params|
      next unless topic_params[:name].present?

      destroy_or_build_topic(topic_params)
    end
  end

  def self.public
    where(public: true)
  end

  private

  def destroy_or_build_topic(params)
    topic = Topic.find_or_create_by(name: params[:name])
    if (params[:_destroy] != 'false') && topics.include?(topic)
      topics.destroy(topic)
    else
      ticket_topics.build(topic: topic) unless topics.include?(topic)
    end
  end
end
