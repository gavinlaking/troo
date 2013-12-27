module Troo
  module CLI
    class Main < ThorFixes
      class_option :debug, type: :boolean, desc: "Enable debugging."

      desc "refresh", "Refresh all data"
      method_option :lists, type: :boolean, desc: "Refresh all lists for current board."
      method_option :cards, type: :boolean, desc: "Refresh all cards for current board."
      def refresh
        if options["lists"]
          return say "Use 'current board <board_id>' to set a current board first." unless Troo::BoardRetrieval.current
          RefreshAll.lists
          say "All lists for current board have been refreshed."
        elsif options["cards"]
          return say "Use 'current board <board_id>' to set a current board first." unless Troo::BoardRetrieval.current
          RefreshAll.cards
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

      desc "show [board|list|card] <id>", "Show the board, list or card with <id>."
      subcommand :show, Troo::CLI::Show

      desc "add [board|list|card|comment] <id>", "Add board, list, card or comment."
      subcommand :add, Troo::CLI::Add

      desc "current [board|list|card] <id>", "Set board, list or card to be current."
      subcommand :current, Troo::CLI::Current

      desc "move <card_id> <list_id>", "Move a card <card_id> to list <list_id>."
      def move(card_id, list_id)
        result = MoveCard.with(card_id, list_id)

        Troo::ExternalCard.fetch(result.external_card_id, { mode: :card, comments: false })
        Troo::ExternalCard.fetch(result.source_list_id, { mode: :list })
        Troo::ExternalCard.fetch(result.destination_list_id, { mode: :list })

        say "Card moved from '#{result.source_list_name}' to '#{result.destination_list_name}'."
      end
    end
  end
end
