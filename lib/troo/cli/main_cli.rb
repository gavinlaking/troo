module Troo
  module CLI
    class Main < Thor
      class_option :debug, type: :boolean, desc: "Enable debugging."

      desc "refresh", "Refresh all data"
      def refresh
        RefreshAll.perform
        say "All local data has been refreshed."
      end

      desc "cleanup", "Removes all local data"
      def cleanup
        Ohm.redis.flushdb
        say "All local data has been removed."
      end

      desc "version", "Print the version"
      def version
        say "troo #{Troo::VERSION}"
      end

      desc "show [board|list|card] <id>", "Show the board, list or card with <id>"
      subcommand :show, Troo::CLI::Show

      desc "board [subcommand] <args>", "Operate on the board"
      subcommand :board, Troo::CLI::Board

      desc "add [board|list|card] <id>", "Add board, list, or card"
      subcommand :add, Troo::CLI::Add

      desc "current [board|list|card] <id>", "Set board, list or card to be current"
      subcommand :current, Troo::CLI::Current

      desc "move <card_id> <list_id>", "Move a card <card_id> to list <list_id>"
      def move(card_id, list_id)
        result = MoveCard.with(card_id, list_id)

        Troo::ExternalCard.fetch(result.external_card_id, { mode: :card, comments: false })
        Troo::ExternalCard.fetch(result.source_list_id, { mode: :list })
        Troo::ExternalCard.fetch(result.destination_list_id, { mode: :list })

        say "Card moved from '#{result.source_list_name}' to '#{result.destination_list_name}'"
      end
    end
  end
end
