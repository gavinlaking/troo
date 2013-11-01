require "highline/import"
require "hirb"
require "pry"
require "singleton"
require "slop"
require "tempfile"
require "trello"
require "yaml"

require_relative "trlo/configuration"
require_relative "trlo/exceptions"
require_relative "trlo/input"
require_relative "trlo/screen"
require_relative "trlo/version"

require_relative "trlo/board_decorator"
require_relative "trlo/board_presenter"
require_relative "trlo/boards_controller"

require_relative "trlo/list_decorator"
require_relative "trlo/list_presenter"
require_relative "trlo/lists_controller"

require_relative "trlo/card_decorator"
require_relative "trlo/card_presenter"
require_relative "trlo/cards_controller"
require_relative "trlo/actions/create_comment"

module Trlo
  Configuration.load!(File.dirname(__FILE__) + "/../configuration.yml")

  Trello.configure do |config|
    config.consumer_key       = Configuration.instance.key
    config.consumer_secret    = Configuration.instance.secret
    config.oauth_token        = Configuration.instance.oauth_token
    config.oauth_token_secret = Configuration.instance.oauth_token_secret
  end

  opts = Slop.parse(help: true) do
    on '-v', 'Print the version' do
      puts "trlo v#{Trlo::VERSION}"
    end

    command 'boards' do
      on :a, :all,   'Show all boards'

      run do |opts, args|
        options = opts.to_hash
        BoardsController.dispatch!(options, args)
      end
    end

    command 'lists' do
      on :a, :all,   'Show all lists for a <board_id>'

      run do |opts, args|
        options = opts.to_hash
        ListsController.dispatch!(options, args)
      end
    end

    command 'cards' do
      on :a, :all,     'Show all cards for a <list_id>'
      on :c, :comment, 'Comment on a card with <card_id> <comment>'
    #   on :m, :move,    'Move a card from list <list_id> to list <list_id>'

      run do |opts, args|
        options = opts.to_hash
        CardsController.dispatch!(options, args)
      end
    end
  end

rescue => exception
  $stderr.puts "trlo: error: #{exception.message}\n"
  $stderr.puts "stack trace:\n"
  $stderr.puts "#{exception.backtrace.join("\n")}\n"
  exit 1
end
