require 'open-uri'

class Engineer < ApplicationRecord
  kredis_json :github_information
  kredis_flag :fetched

  def github_info
    @github_info ||= begin
      fetch_github_info unless fetched.marked?
      github_information.value
    end
  end

  private

  def fetch_github_info
    fetched.mark(expires_in: 1.minute)
    user_serialized = open("https://api.github.com/users/#{self.gh_nickname}").read
    user = JSON.parse(user_serialized)
    user_hash = {
      bio: user["bio"],
      public_repos: user["public_repos"],
      name: user["name"]
    }
    self.github_information.value = user_hash
  end
end
