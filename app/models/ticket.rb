class Ticket < ApplicationRecord
  belongs_to :submitter, class_name: 'User'

  has_many :ticket_topics, dependent: :destroy
  has_many :topics, through: :ticket_topics

  has_many :comments, foreign_key: :commented_ticket_id, dependent: :destroy
  has_many :commenters, through: :comments, source: :commenter

  has_many :meetings, dependent: :destroy

  has_many :tasks, dependent: :destroy

  validates :title, :description, presence: true

  has_one_attached :attachment

  validate :acceptable_attachment

  scope :resolved, -> { where(resolved: true) }
  scope :unresolved, -> { where(resolved: false) }
  scope :published, -> { where(public: true) }
  scope :unpublished, -> { where(public: false) }
  scope :order_by_submission, -> { order(created_at: :desc) }

  def self.search(query)
    if query.present?
      where('title LIKE ?', "%#{query}%")
    else
      all
    end
  end

  def topics_attributes=(attributes)
    attributes.values.each do |topic_params|
      next unless topic_params[:name].present?

      destroy_or_build_topic(topic_params)
    end
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

  def acceptable_attachment
    return unless attachment.attached?

    unless attachment.byte_size <= 1.megabyte
      errors.add(:attachment, 'is too big')
    end

    acceptable_types = ['image/jpeg', 'image/png']
    unless acceptable_types.include?(attachment.content_type)
      errors.add(:attachment, 'must be a JPEG or PNG')
    end
  end
end
