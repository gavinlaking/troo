require "celluloid/autostart"
require "data_mapper"
require "digest"
require "erb"
require "logger"
require "pry"
require "tempfile"
require "term/ansicolor"
require "thor"
require "trello"
require "yaml"

require_relative "ctrlo/version"

require_relative "ctrlo/helpers"
require_relative "ctrlo/input"

require_relative "ctrlo/actions/create_comment"
require_relative "ctrlo/actions/create_list"
require_relative "ctrlo/actions/move_card"
require_relative "ctrlo/actions/refresh_all"
require_relative "ctrlo/actions/set_current"

require_relative "ctrlo/external/external_board"
require_relative "ctrlo/external/external_card"
require_relative "ctrlo/external/external_comment"
require_relative "ctrlo/external/external_list"
require_relative "ctrlo/external/external_member"
require_relative "ctrlo/external/proxy_card"
require_relative "ctrlo/external/proxy_list"

require_relative "ctrlo/presentation/screen"
require_relative "ctrlo/presentation/template"
require_relative "ctrlo/presentation/board_decorator"
require_relative "ctrlo/presentation/board_presenter"
require_relative "ctrlo/presentation/card_decorator"
require_relative "ctrlo/presentation/comment_decorator"
require_relative "ctrlo/presentation/list_decorator"
require_relative "ctrlo/presentation/list_presenter"

require_relative "ctrlo/models/model_helpers"
require_relative "ctrlo/models/board"
require_relative "ctrlo/models/board_retrieval"
require_relative "ctrlo/models/board_persistence"
require_relative "ctrlo/models/card"
require_relative "ctrlo/models/card_retrieval"
require_relative "ctrlo/models/card_persistence"
require_relative "ctrlo/models/comment"
require_relative "ctrlo/models/comment_retrieval"
require_relative "ctrlo/models/comment_persistence"
require_relative "ctrlo/models/list"
require_relative "ctrlo/models/list_retrieval"
require_relative "ctrlo/models/list_persistence"
require_relative "ctrlo/models/member"
require_relative "ctrlo/models/member_retrieval"
require_relative "ctrlo/models/member_persistence"

require_relative "ctrlo/cli/board_cli"
require_relative "ctrlo/cli/card_cli"
require_relative "ctrlo/cli/list_cli"
require_relative "ctrlo/cli/add_cli"
require_relative "ctrlo/cli/current_cli"
require_relative "ctrlo/cli/main_cli"

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
