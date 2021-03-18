require 'open-uri'

class Engineer < ApplicationRecord
  kredis_json :github_information # store a hash of info coming from gh
  kredis_flag :fetched # stores an expiration date

  def github_info
    @github_info ||= begin
      fetch_github_info unless fetched.marked? # returns true of not expired
      github_information.value
    end
  end

  private

  def fetch_github_info
    # 1. Set the flag as marked (expiration)
    fetched.mark(expires_in: 1.minute)
    # 2. Make an api call to GH
    user_serialized = URI.open("https://api.github.com/users/#{gh_nickname}").read
    user_data = JSON.parse(user_serialized)

    # 3. Set the github_information value
    github_information.value = {
      name: user_data["name"],
      bio: user_data["bio"],
      public_repos: user_data["public_repos"],
      timestamp: Time.now
    }
  end
end
