class Trigger < ApplicationRecord
  belongs_to :repository
  has_many :checks
end
