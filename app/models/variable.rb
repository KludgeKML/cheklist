class Variable < ApplicationRecord
  belongs_to :check

  attr_accessor :name, :value
end
