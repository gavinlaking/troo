# Configuration is a singleton and must be tested in isolation.
require "minitest/autorun"
require "minitest/pride"
require "singleton"
require "yaml"
require_relative "../../../lib/trlo/configuration.rb"

module Trlo
  describe Configuration do
    before do
      Configuration.load!(File.dirname(__FILE__) + "/../../../configuration.yml.example")
    end

    it "configures the key" do
      Configuration.instance.key.must_equal "some_key"
    end

    it "configures the secret" do
      Configuration.instance.secret.must_equal "some_secret"
    end

    it "configures the oauth token" do
      Configuration.instance.oauth_token.must_equal "some_oauth_token"
    end

    it "configures the oauth token secret" do
      Configuration.instance.oauth_token_secret.must_equal "some_oauth_token_secret"
    end
  end
end
