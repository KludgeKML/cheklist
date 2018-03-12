module Checks
	class Base
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
	end
end

require 'checks/file_changed'
require 'checks/merge_from'
