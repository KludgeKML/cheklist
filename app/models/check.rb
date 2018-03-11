require 'checks/base'

# A check or test that might be called by a trigger
# and provides a success or fail to the commit that
# caused the trigger.
class Check < ApplicationRecord
  belongs_to :trigger
  has_many :variables

  attr_accessor :description

  include ActiveModel::Validations
  validates_with Validators::CheckValidator

  def check_object
  	@check_object ||= Checks.const_get(check_type).new
  end
end
