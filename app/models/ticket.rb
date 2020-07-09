class Ticket < ApplicationRecord
  belongs_to :submitter, class_name: 'User'

  def self.public
    where(public: true)
  end
end
