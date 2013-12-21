require "celluloid/autostart"
require "date"
require "digest"
require "erb"
require "logger"
require "ohm"
require "ohm/contrib"
require "pry"
require "tempfile"
require "term/ansicolor"
require "thor"
require "trello"
require "yaml"

require_relative "troo/version"
require_relative "troo/input"

require_relative "troo/actions/create_comment"
require_relative "troo/actions/create_list"
require_relative "troo/actions/move_card"
require_relative "troo/actions/refresh_all"
require_relative "troo/actions/set_current"

require_relative "troo/external/external_board"
require_relative "troo/external/external_card"
require_relative "troo/external/external_comment"
require_relative "troo/external/external_list"
require_relative "troo/external/external_member"
require_relative "troo/external/proxy_card"
require_relative "troo/external/proxy_list"

require_relative "troo/display/decorator_helpers"
require_relative "troo/display/board_decorator"
require_relative "troo/display/card_decorator"
require_relative "troo/display/comment_decorator"
require_relative "troo/display/list_decorator"
require_relative "troo/display/member_decorator"
require_relative "troo/display/overview_presenter"
require_relative "troo/display/board_presenter"

require_relative "troo/presentation/template"

require_relative "troo/models/model_helpers"
require_relative "troo/models/board"
require_relative "troo/models/board_retrieval"
require_relative "troo/models/board_persistence"
require_relative "troo/models/card"
require_relative "troo/models/card_retrieval"
require_relative "troo/models/card_persistence"
require_relative "troo/models/comment"
require_relative "troo/models/comment_retrieval"
require_relative "troo/models/comment_persistence"
require_relative "troo/models/list"
require_relative "troo/models/list_retrieval"
require_relative "troo/models/list_persistence"
require_relative "troo/models/member"
require_relative "troo/models/member_retrieval"
require_relative "troo/models/member_persistence"

require_relative "troo/cli/board_cli"
require_relative "troo/cli/card_cli"
require_relative "troo/cli/list_cli"
require_relative "troo/cli/add_cli"
require_relative "troo/cli/current_cli"
require_relative "troo/cli/main_cli"

module Troo
  def self.config
    @config ||= OpenStruct.new(YAML.load_file(File.dirname(__FILE__) + "/../configuration.yml"))
  end

  Celluloid.logger = Logger.new("logs/celluloid.log")
  Trello.logger    = Logger.new("logs/trello.log")

  if ARGV.include?("--debug")
    ARGV.delete("--debug")
  end

  Trello.configure do |trello|
    trello.consumer_key       = config.key
    trello.consumer_secret    = config.secret
    trello.oauth_token        = config.oauth_token
    trello.oauth_token_secret = config.oauth_token_secret
  end

  Ohm.connect(db: config.main_db)
end
