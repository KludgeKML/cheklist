module Checks
	class Base
    def variables
      {}
    end

		def initialize(check_record)
			@client = Rails.application.config.github_api_client
			@check_record = check_record
		end

		def repository
			@check_record.trigger.repository
		end

    def passed?(pr_id: nil, commit_sha: nil)
      false
    end

    def variable_names
      variables.keys
    end

    def method_missing(m, *args, &block)
      return variable_value(m) if variable_names.include?(m.to_sym)
      super
    end

    def variable_value(name)
      raise "Not a valid variable: #{name}" unless variable_names.include?(name)
      v = @check_record.variables.where(name: name).first
      v ? v.value : variables[name.to_sym][:default]
    end
	end
end

require 'checks/file_changed'
require 'checks/merge_from'
