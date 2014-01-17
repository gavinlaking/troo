module Troo
  module CLI
    class Main < ThorFixes
      default_task :status

      class_option :debug, type: :boolean, desc: "Enable debugging."

      desc "status", "Get troo status."
      def status
        board_count = Troo::Board.count
        list_count  = Troo::List.count
        card_count  = Troo::Card.count

        if board_count > 0
          if board = Troo::BoardRetrieval.default
            say "Board: #{BoardDecorator.new(board).short}"
          else
            say "Board: No default set."
          end
        else
          say "No local board data."
        end

        if list_count > 0
          if list = Troo::ListRetrieval.default
            say "List: #{ListDecorator.new(list).short}"
          else
            say "List: No default set."
          end
        else
          say "No local list data."
        end

        if card_count > 0
          if card = Troo::CardRetrieval.default
            say "Card: #{CardDecorator.new(card).short}"
          else
            say "Card: No default set."
          end
        else
          say "No local card data."
        end

        puts [plural(board_count, "board"),
              plural(list_count, "list"),
              plural(card_count, "card") ].join(", ")
        puts

        help
      end

      private

      def plural(size, singular)
        (size == 1) ? "#{size} #{singular}" : "#{size} #{singular}s"
      end

      public

      desc "refresh", "Refresh all data for default board."
      method_option :all, type: :boolean, desc: "Refresh all boards, lists, cards and comments."
      method_option :lists, type: :boolean, desc: "Refresh all lists for default board."
      method_option :cards, type: :boolean, desc: "Refresh all cards for default board."
      def refresh
        if options["all"]
          RefreshAll.all(nil, options)
          say "All local data has been refreshed."
        else
          if board = Troo::BoardRetrieval.default
            if options["lists"]
              RefreshAll.lists(board, options)
              say "All lists for the default board have been refreshed."
            elsif options["cards"]
              RefreshAll.cards(board, options)
              say "All cards for the default board have been refreshed."
            else
              RefreshAll.default(board, options)
              say "All data for the default board has been refreshed."
            end
          else
            say "Use 'troo default board <board_id>' to set a default board first."
          end
        end
      rescue Troo::InvalidAccessToken
        say "Your Trello access credentials have expired, please renew and try again."
      end

      desc "cleanup", "Removes all local data."
      def cleanup
        if yes?("This will remove all local data, are you sure?")
          Ohm.redis.flushdb
          say "All local data has been removed."
        end
      end

      desc "version", "Print the version."
      def version
        say "troo #{Troo::VERSION}"
      end

      desc "show [board|list|card|comment] <id>", "Show the board, list, card or comment with <id>."
      subcommand :show, Troo::CLI::Show

      desc "add [board|list|card|comment] <id>", "Add board, list, card or comment."
      subcommand :add, Troo::CLI::Add

      desc "default [board|list|card] <id>", "Set board, list or card to be default."
      subcommand :default, Troo::CLI::Default

      desc "move <card_id> <list_id>", "Move a card <card_id> to list <list_id>."
      def move(card_id, list_id)
        if card = Troo::CardRetrieval.retrieve(card_id)
          if list = Troo::ListRetrieval.retrieve(list_id)
            if result = MoveCard.with(card, list)
              say "Card moved from '#{card.list.name}' to '#{list.name}'."
            else
              say "Card could not be moved."
            end
          else
            say "Card could not be moved, as list was not found."
          end
        else
          say "Card could not be moved, as card was not found."
        end
      rescue Troo::InvalidAccessToken
        say "Your Trello access credentials have expired, please renew and try again."
      end
    end
  end
end
