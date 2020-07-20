# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  first_name             :string
#  last_name              :string
#  avatar_url             :string
#  role                   :integer          default("member")
#
class User < ApplicationRecord
  enum role: { member: 0, agent: 1, manager: 2 }

  validates :first_name, :last_name, presence: true

  has_many :submitted_tickets, foreign_key: 'submitter_id', class_name: 'Ticket'

  has_many :comments, foreign_key: :commenter_id
  has_many :commented_tickets, through: :comments

  has_many :requested_users, foreign_key: :requester_id, class_name: 'Meeting'
  has_many :requestees, through: :requested_users
  has_many :requesting_users, foreign_key: :requestee_id, class_name: 'Meeting'
  has_many :requesters, through: :requesting_users

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_one_attached :avatar

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
end
