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
  accepts_nested_attributes_for :topics, allow_destroy: true, reject_if: proc { |attr| attr[:name].blank? }

  has_many :comments
  has_many :commenters, through: :comments, class_name: 'User'

  validates :title, :description, :submitter, presence: true

  def topics_attributes=(attributes)
    #TODO: ask Jenn about this bug
    
    attributes.values.each do |topic_params|
      topic = Topic.find_or_create_by(name: topic_params[:name])
      if !!topic_params[:_destroy] && topics.include?(topic)
        topics.destroy(topic)
      else
        ticket_topics.build(topic: topic) unless topics.include?(topic)
      end 
    end
  end

  def self.public
    where(public: true)
  end
end
