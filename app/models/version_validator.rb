# Validates a commit in a PR based on whether the VERSION
# file in the merging commit is different from the pull 
# target (i.e. the committer has updated the version)

class VersionValidator
  def initialize
    @client = Rails.application.config.github_api_client
  end

  def validate(repo, pull_request_id)
  	pr = @client.pull_request(repo, pull_request_id)
  	files = @client.pull_request_files(repo, pull_request_id)
  	passed = false
	files.each do |f|
		passed = true if f.filename == 'VERSION'
	end
	commit = pr.head.sha
	if passed
		success(repo, commit)
	else
		failure(repo, commit)
	end
  end

  def success(repo, commit)
    Rails.logger.info("VersionValidator: success")
  	@client.create_status(repo, commit, 'success', context: 'chekblok', description: 'VERSION file updated')
  end

  def failure(repo, commit, message: 'version file not updated')
    Rails.logger.info("VersionValidator: failed")
  	@client.create_status(repo, commit, 'failure', context: 'chekblok', description: 'VERSION file not updated')
  end
end
