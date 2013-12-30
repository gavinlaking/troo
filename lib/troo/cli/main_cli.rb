module Troo
  module CLI
    class Main < ThorFixes
      class_option :debug, type: :boolean, desc: "Enable debugging."

      desc "refresh", "Refresh all data"
      method_option :lists, type: :boolean, desc: "Refresh all lists for current board."
      method_option :cards, type: :boolean, desc: "Refresh all cards for current board."
      def refresh
        if options["lists"]
          return say "Use 'troo current board <board_id>' to set a current board first." unless Troo::BoardRetrieval.current
          RefreshAll.lists(options)
          say "All lists for current board have been refreshed."
        elsif options["cards"]
          return say "Use 'troo current board <board_id>' to set a current board first." unless Troo::BoardRetrieval.current
          RefreshAll.cards(options)
          say "All cards for current board have been refreshed."
        else
          RefreshAll.perform(options)
          say "All local data has been refreshed."
        end
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

      desc "current [board|list|card] <id>", "Set board, list or card to be current."
      subcommand :current, Troo::CLI::Current

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
      end
    end
  end
end
