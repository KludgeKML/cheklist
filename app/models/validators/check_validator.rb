module Validators
  class CheckValidator < ActiveModel::Validator
    def validate(record)
      unless Checks.const_defined?(record.check_type.to_sym)
        record.errors[:check_type] << "#{record.check_type} not a valid check"
      end
    end
  end
end
