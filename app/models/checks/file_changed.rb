# Checks to see if a file has been updated
module Checks
	class FileChanged < BaseCheck
		def description
			"Has a file been updated?"
		end

		def description_complex
			"Has %{Filepath} been updated?"
		end

		def variables
			['Filepath']
		end

		def passed?
  			pr = @client.pull_request(repository, pull_request_id)
  			files = @client.pull_request_files(repository, pull_request_id)
  			passed = false
			files.each do |f|
				passed = true if f.filename == 'VERSION'
			end
			commit = pr.head.sha			
		end
	end
end
