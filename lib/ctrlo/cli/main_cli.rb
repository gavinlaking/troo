module Ctrlo
  module CLI
    class Main < Thor
      include Ctrlo::Helpers

      class_option :debug, type: :boolean, desc: "Enable debugging."

      desc "refresh", "Refresh all data"
      def refresh
        RefreshAll.perform
      end

      desc "cleanup", "Removes all local data"
      def cleanup
        DataMapper.auto_migrate!
      end

      desc "version", "Print the version"
      def version
        puts "ctrlo #{Ctrlo::VERSION}"
      end

      desc "board [subcommand] <args>", "Operate on the board"
      subcommand :board, Ctrlo::CLI::Board

      desc "list [subcommand] <args>", "Operate on the list"
      subcommand :list, Ctrlo::CLI::List

      desc "card [subcommand] <args>", "Operate on the card"
      subcommand :card, Ctrlo::CLI::Card

      desc "add [board|list|card] <id>", "Add board, list, or card"
      subcommand :add, Ctrlo::CLI::Add

      desc "current [board|list|card] <id>", "Set board, list or card to be current"
      subcommand :current, Ctrlo::CLI::Current

      desc "comment <card_id> (<comment>)", "Comment on a card with <card_id> <comment>"
      def comment(card_id, comment = nil)
        Ctrlo::CreateComment.for(card_id, comment)

        Ctrlo::ExternalCard.fetch(card_id, { mode: :card })
        Ctrlo::ExternalComments.fetch(card_id, { mode: :card })
      end

      desc "move <card_id> <list_id>", "Move a card <card_id> to list <list_id>"
      def move(card_id, list_id = nil)
        unless list_id
          #Output.render(Ctrlo::Board.current.lists)
          error("Please choose a destination list. (Move a card <card_id> to list <list_id>)")
          exit 1
        end

        result = MoveCard.with(card_id, list_id)

        Ctrlo::ExternalList.fetch(result.source_list_id, { mode: :list })
        Ctrlo::ExternalList.fetch(result.destination_list_id, { mode: :list })
        Ctrlo::ExternalCard.fetch(card_id, { mode: :card })
      end


    end
  end
end
