# Checks to see if a file has been updated
module Checks
	class FileChanged < Base
		def description
			"Has a file been updated?"
		end

		def description_complex
			"Has #{filepath} been updated?"
		end

		def variables
			['filepath']
		end

		def passed?(pr_id: nil, commit_sha: nil)
  		files = @client.pull_request_files(repository.name, pr_id)
			files.each do |f|
				return true if f.filename == filepath
			end
			false
		end

		def filepath
			v = @check_record.variables.where(name: 'filepath').first
			v ? v.value : 'README'
		end
	end
end
