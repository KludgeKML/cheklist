# Checks to see if a pull request is from a specific branch
module Checks
  class MergeFrom < Base
    def variables
      {
        branch: {
          default: 'master',
          description: 'the branch name that this merge must be from'
        }
      }
    end

    def description
      "Is a pull request from a specific branch?"
    end

    def description_complex
      "Is this merge from #{branch}?"
    end

    def passed?(pr_id: nil, commit_sha: nil)
      # @todo: return true if merging from the named branch

      false
    end
  end
end