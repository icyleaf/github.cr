require "./gitlab/**"

module Gitlab
  VERSION = "0.6.0"

  # Alias for Gitlab::Client.new
  def self.client(endpoint : String, token : String) : Client
    Client.new(endpoint, token)
  end
end
