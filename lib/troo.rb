require_relative "troo/troo"
require_relative "troo/version"

module Troo
  def self.config
    @config ||= OpenStruct.new(YAML.load_file(File.dirname(__FILE__) + "/../configuration.yml"))
  rescue Errno::ENOENT
    warn "Cannot continue, no configuration file."
    exit!
  end

  def self.logger
    @logger ||= Logger.new("logs/troo.log")
  end

  Trello.logger    = Logger.new("logs/trello.log")
  Trello.configure do |trello|
    trello.consumer_key       = config.key
    trello.consumer_secret    = config.secret
    trello.oauth_token        = config.oauth_token
    trello.oauth_token_secret = config.oauth_token_secret
  end

  Ohm.connect(db: config.main_db)
end
