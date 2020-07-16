# == Schema Information
#
# Table name: posts
#
#  id      :integer          not null, primary key
#  title   :string
#  content :text
#  vote    :integer
#  user_id :integer          not null
#
class Post < ApplicationRecord
  belongs_to :user
  has_many :post_topics, dependent: :destroy

  validates :title, :content, presence: true

  has_one_attached :picture
end
