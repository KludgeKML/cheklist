class Check < ApplicationRecord
  belongs_to :trigger
  has_many :variables
end
