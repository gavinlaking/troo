module Troo
  module CLI
    class Main < Thor
      class_option :debug, type: :boolean, desc: "Enable debugging."

      desc "refresh", "Refresh all data"
      def refresh
        # RefreshAll.perform
        say "Not implemented yet."
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

      desc "comment <card_id> (<comment>)", "Comment on a card with <card_id> <comment>"
      def comment(card_id, comment = nil)
        # Troo::CreateComment.for(card_id, comment)

        # Troo::ExternalCard.fetch(card_id, { mode: :card })
        # Troo::ExternalComments.fetch(card_id, { mode: :card })
        say "Not implemented yet."
      end

      desc "move <card_id> <list_id>", "Move a card <card_id> to list <list_id>"
      def move(card_id, list_id = nil)
        # unless list_id
        #   #Output.render(Troo::Board.current.lists)
        #   puts "Please choose a destination list. (Move a card <card_id> to list <list_id>)"
        #   exit 1
        # end

        # result = MoveCard.with(card_id, list_id)

        # Troo::ExternalList.fetch(result.source_list_id, { mode: :list })
        # Troo::ExternalList.fetch(result.destination_list_id, { mode: :list })
        # Troo::ExternalCard.fetch(card_id, { mode: :card })
        say "Not implemented yet."
      end
    end
  end
end
