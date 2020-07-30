class User < ApplicationRecord
  enum role: { member: 0, agent: 1, manager: 2 }

  validates :first_name, :last_name, presence: true

  has_many :submitted_tickets, foreign_key: 'submitter_id', class_name: 'Ticket'

  has_many :comments, foreign_key: :commenter_id
  has_many :commented_tickets, through: :comments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_one_attached :avatar

  validate :acceptable_avatar

  def meetings
    Meeting.where('requester_id = ? OR requestee_id = ?', id, id)
  end

  def tasks
    Task.where('assigner_id = ? OR assignee_id = ?', id, id)
  end

  def tasked_tickets
    ticket_id_arr = tasks.distinct.pluck(:ticket_id)
    Ticket.find(ticket_id_arr)
  end

  def self.with_most_tickets
    order(:submitted_tickets, count: :desc).first
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    user ||= User.create(first_name: data['first_name'],
                         last_name: data['last_name'],
                         email: data['email'],
                         password: Devise.friendly_token[0, 20],
                         avatar_url: data['image'])
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.google_oauth2_data'] && session['devise.google_oauth2_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def initials
    first_name[0].upcase + last_name[0].upcase
  end

  private

  def acceptable_avatar
    return unless avatar.attached?

    unless avatar.byte_size <= 1.megabyte
      errors.add(:avatar, 'is too big')
    end

    acceptable_types = ['image/jpeg', 'image/png']
    unless acceptable_types.include?(avatar.content_type)
      errors.add(:avatar, 'must be a JPEG or PNG')
    end
  end
end
