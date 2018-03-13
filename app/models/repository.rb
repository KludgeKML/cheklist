class Repository < ApplicationRecord
  belongs_to :user
  has_many :triggers

  def create_status(event_type, data, value, options = {})
  end
end
