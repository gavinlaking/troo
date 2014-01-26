require_relative "troo/troo"
require_relative "troo/version"

module Troo
  class InvalidAccessToken < StandardError; end

  def self.config
    @config ||= OpenStruct.new(YAML.load_file(Dir.home + "/.trooconf"))
  rescue Errno::ENOENT
    warn "No configuration file found..."
    src = File.dirname(__FILE__) + "/../configuration.yml.example"
    dst = Dir.home + "/.trooconf"
    FileUtils.cp(src, dst)
    warn "New configuration file created at '#{Dir.home}/.trooconf'"
    exit!
  end

  def self.logger
    @logger ||= Logger.new("logs/troo.log")
  end

  # Trello.logger = Logger.new("logs/trello.log")
  Trello.configure do |trello|
    trello.consumer_key       = config.key
    trello.consumer_secret    = config.secret
    trello.oauth_token        = config.oauth_token
    trello.oauth_token_secret = config.oauth_token_secret
  end

  if ARGV.include?("--test")
    ARGV = ARGV.delete_if { |arg| arg == "--test" }
    Ohm.connect(db: config.test_db)
  else
    Ohm.connect(db: config.main_db)
  end
end
