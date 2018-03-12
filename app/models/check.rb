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

  def description
    check_object.description_complex
  end

  def passed?(pr_id: nil, commit_sha: nil)
    check_object.passed?(pr_id: pr_id, commit_sha: commit_sha)
  end

  def check_object
  	@check_object ||= Checks.const_get(check_type).new(self)
  end
end
