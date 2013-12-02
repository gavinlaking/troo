require "celluloid/autostart"
require "data_mapper"
require "digest"
require "erb"
require "highline/import"
require "hirb"
require "logger"
require "pry"
require "tempfile"
require "term/ansicolor"
require "thor"
require "trello"
require "yaml"

require_relative "ctrlo/input"
require_relative "ctrlo/output"
require_relative "ctrlo/refresh_all"
require_relative "ctrlo/set_current"
require_relative "ctrlo/ctrlo_cli"
require_relative "ctrlo/version"

require_relative "ctrlo/external/external_board"
require_relative "ctrlo/external/external_card"
require_relative "ctrlo/external/external_comment"
require_relative "ctrlo/external/external_list"
require_relative "ctrlo/external/external_member"

require_relative "ctrlo/views/screen"
require_relative "ctrlo/views/card_decorator"

require_relative "ctrlo/models/board"
require_relative "ctrlo/models/card"
require_relative "ctrlo/models/comment"
require_relative "ctrlo/models/create_comment"
require_relative "ctrlo/models/list"
require_relative "ctrlo/models/member"
require_relative "ctrlo/models/move_card"
require_relative "ctrlo/models/show_card"

module Ctrlo
  Celluloid.logger = nil

  if ARGV.include?("--debug")
    ARGV.delete("--debug")
    Celluloid.logger = Logger.new(STDERR)
    DataMapper::Logger.new(STDOUT, :debug)
  end

  DataMapper.setup(:default, "sqlite://#{File.expand_path(File.dirname(__FILE__))}/../ctrlo.db")
  DataMapper::Model.raise_on_save_failure = true
  DataMapper.finalize
  DataMapper.auto_upgrade!

  config = YAML.load_file(File.dirname(__FILE__) + "/../configuration.yml")
  Trello.configure do |trello|
    trello.consumer_key       = config.fetch("key")
    trello.consumer_secret    = config.fetch("secret")
    trello.oauth_token        = config.fetch("oauth_token")
    trello.oauth_token_secret = config.fetch("oauth_token_secret")
  end
end
