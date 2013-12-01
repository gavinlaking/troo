require "celluloid/autostart"
require "data_mapper"
require "digest"
require "erb"
require "highline/import"
require "hirb"
require "pry"
require "tempfile"
require "term/ansicolor"
require "thor"
require "trello"
require "yaml"

require_relative "trlo/input"
require_relative "trlo/output"
require_relative "trlo/refresh_all"
require_relative "trlo/set_current"
require_relative "trlo/trlo_cli"
require_relative "trlo/version"

require_relative "trlo/external/external_board"
require_relative "trlo/external/external_card"
require_relative "trlo/external/external_comment"
require_relative "trlo/external/external_list"
require_relative "trlo/external/external_member"

require_relative "trlo/models/board"
require_relative "trlo/models/card"
require_relative "trlo/models/comment"
require_relative "trlo/models/create_comment"
require_relative "trlo/models/list"
require_relative "trlo/models/member"
require_relative "trlo/models/move_card"
require_relative "trlo/models/show_card"

module Trlo
  #Celluloid.logger = nil
  DataMapper::Logger.new(STDOUT, :debug)
  DataMapper.setup(:default, "sqlite://#{File.expand_path(File.dirname(__FILE__))}/trlo.db")
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
