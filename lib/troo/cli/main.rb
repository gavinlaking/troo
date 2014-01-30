module Troo
  module CLI
    class Main < ThorFixes
      class_option :debug, type: :boolean, desc: "Enable debugging."

      desc "status",
           "Get troo status."
      def status
        say "Status:"
        say Commands::Status.dispatch(:board)
        say Commands::Status.dispatch(:list)
        say Commands::Status.dispatch(:card)
      end

      desc "cleanup",
           "Removes all local data."
      def cleanup
        if yes?("This will remove all local data, are you sure?")
          Ohm.redis.flushdb
          say "All local data has been removed."
        end
      end

      desc "version",
           "Print the version."
      def version
        say "troo #{Troo::VERSION}"
      end

      desc "show [board|list|card|comment] <id>",
           "Show the board, list, card or comment with <id>."
      subcommand :show, CLI::Show

      desc "add [board|list|card|comment] <id>",
           "Add board, list, card or comment."
      subcommand :add, CLI::Add

      desc "default [board|list|card] <id>",
           "Set board, list or card to be default."
      subcommand :default, CLI::Default

      desc "refresh [board|list|card] <id>",
           "Refresh board, list or card with <id>."
      subcommand :refresh, CLI::Refresh
    end
  end
end
