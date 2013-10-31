require "hirb"
require "pry"
require "singleton"
require "slop"
require "trello"
require "yaml"

require_relative "trlo/configuration"
require_relative "trlo/version"

module Trlo
  Configuration.load!(File.dirname(__FILE__) + "/../configuration.yml")

  Trello.configure do |config|
    config.consumer_key       = Configuration.instance.key
    config.consumer_secret    = Configuration.instance.secret
    config.oauth_token        = Configuration.instance.oauth_token
    config.oauth_token_secret = Configuration.instance.oauth_token_secret
  end
end
