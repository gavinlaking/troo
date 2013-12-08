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

      desc "board [SUBCOMMAND] <args>", "Operate on the board"
      subcommand :board, Ctrlo::CLI::Board

      desc "list [SUBCOMMAND] <args>", "Operate on the list"
      subcommand :list, Ctrlo::CLI::List

      desc "card [SUBCOMMAND] <args>", "Operate on the card"
      subcommand :card, Ctrlo::CLI::Card
    end
  end
end
