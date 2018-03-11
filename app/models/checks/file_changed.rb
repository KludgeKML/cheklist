# Checks to see if a file has been updated
module Checks
	class FileChanged < Base
		def description
			"Has a file been updated?"
		end

		def description_complex
			"Has %{Filepath} been updated?"
		end

		def variables
			['filepath']
		end

		def passed?
  			pr = @client.pull_request(repository, pull_request_id)
  			files = @client.pull_request_files(repository, pull_request_id)
  			passed = false
			files.each do |f|
				passed = true if f.filename == filepath
			end
			commit = pr.head.sha			
		end

		def filepath
			variables.where(name: 'filepath').value || 'README'
		end
	end
end
