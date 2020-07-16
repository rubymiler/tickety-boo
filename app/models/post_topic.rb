# == Schema Information
#
# Table name: post_topics
#
#  id       :integer          not null, primary key
#  topic_id :integer          not null
#  post_id  :integer          not null
#
class PostTopic < ApplicationRecord
  belongs_to :post
  belongs_to :topic
end
