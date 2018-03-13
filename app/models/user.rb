class User < ApplicationRecord
	has_many :repositories

  def self.find_or_create_from_auth_hash(auth)
    where(display_name: auth.info[:nickname]).first_or_create do |user|
      user.display_name = auth.info[:nickname]
    end
  end
end
