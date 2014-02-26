module Troo
  module CLI
    class Main < ThorFixes
      desc 'init',
           'Prepare to use Troo.'
      def init
        if File.exist?(destination)
          say 'A configuration file already exists in your home ' \
              'directory.'
        else
          say 'A configuration file does not exist in your home ' \
              'directory, creating one...'
          FileUtils.cp(source, destination)
        end
      end

      desc 'status',
           'Get troo status.'
      def status
        say 'Status:'
        say Commands::Status::Board.dispatch
        say Commands::Status::List.dispatch
        say Commands::Status::Card.dispatch
      end

      desc 'cleanup',
           'Removes all local data.'
      def cleanup
        if yes?('This will remove all local data, are you sure?')
          Ohm.redis.flushdb
          say "\n" + 'All local data has been removed.'
        else
          say "\n" + 'No local data has been removed.'
        end
      end

      desc 'version',
           'Print the version.'
      def version
        say "troo #{Troo::VERSION}"
      end

      desc 'show [boards|board|list|card|comments] <id>',
           'Show all the boards or the board, list, card with ' \
           '<id>. Also, show all comments for card with <id>.'
      subcommand :show, CLI::Show

      desc 'add [board|list|card|comment] <id>',
           'Add board, list, card or comment.'
      subcommand :add, CLI::Add

      desc 'default [board|list|card] <id>',
           'Set board, list or card to be default.'
      subcommand :default, CLI::Default

      desc 'refresh [board|list|card] <id>',
           'Refresh board, list or card with <id>.'
      subcommand :refresh, CLI::Refresh

      desc 'move <card_id> <list_id> (<board_id>)',
           'Move card with <card_id> to list with <list_id> ' \
           'optionally to another board with <board_id>.'
      def move(card_id, list_id, board_id = nil)
        say Commands::Move::Card.dispatch(card_id, list_id, board_id)
      end

      private

      def source
        File.dirname(__FILE__) + '/../.trooconf.example'
      end

      def destination
        Dir.home + '/.trooconf'
      end
    end
  end
end
