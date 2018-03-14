class User < ApplicationRecord
	has_many :repositories

  def self.find_or_create_from_auth_hash(auth)
    where(display_name: auth.info[:nickname]).first_or_create do |user|
      user.display_name = auth.info[:nickname]
      user.access_token = auth.credentials.token
    end
  end

  def user_octokit_client
    @user_octokit_client ||= Octokit::Client.new(access_token: access_token)
  end

  def list_available_installations
    info = user_octokit_client.find_user_installations(accept: Octokit::Preview::PREVIEW_TYPES[:integrations])
    info.installations
  end

  def list_repos_in_installation(installation_id)
    info = user_octokit_client.find_installation_repositories_for_user(installation_id, accept: Octokit::Preview::PREVIEW_TYPES[:integrations])
    info.repositories
  end

  def make_repo_records_from_installations
    list_available_installations.each do |installation|
      list_repos_in_installation(installation.id).each do |repo|
        repositories.create(name: repo.full_name) unless repositories.where(name: repo.full_name).count > 0
      end
    end
  end
end
