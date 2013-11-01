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
      #on :s, :show,  'Show all lists and cards for a <board_id>'

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
    #   on :c, :create,  'Add a new card to list <list_id> <name>'
    #   on :d, :delete,  'Delete a card from list <list_id> <id>'
    #   on :s, :show,    'Show a card from list <list_id>'
    #   on :c, :comment, 'Comment on a card with <card_id> <comment>'
    #   on :m, :move,    'Move a card from list <list_id> to list <list_id>'

      run do |opts, args|
        options = opts.to_hash
        CardsController.dispatch!(options, args)
      end
    end
  end

rescue => exception
  $stderr.puts "trlo: error: #{exception.message}"
  exit 1

  # Some debugging code
  # puts "-----------------------------------------"
  # BoardsController.new.all
  # puts "-----------------------------------------"
  # BoardsController.new.show("51239ff5469f1b1460000188")
  # puts "-----------------------------------------"
  # board_id = "51239ff5469f1b1460000188"
  # ListsController.new.all(board_id)
  # puts "-----------------------------------------"
  # list_id = "51239ff5469f1b1460000189"
  # ListsController.new.show(list_id)
  # puts "-----------------------------------------"
  # CardsController.new.all(list_id)
  # puts "-----------------------------------------"
  # card_id = "5260fb1895e4fba368001520"
  # CardsController.new.show(card_id)
  # puts "-----------------------------------------"
end
