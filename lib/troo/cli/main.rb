module Troo
  module CLI
    class Main < ThorFixes
      desc 'status',
           'Get troo status.'
      def status
        say heading('Status:')
        say Commands::Status.dispatch(Troo::Board)
        say Commands::Status.dispatch(Troo::List)
        say Commands::Status.dispatch(Troo::Card)

        say "\n" + heading('Last refreshed:')

        if Troo::Refresh.last_performed_at?
          say Troo::Refresh.last_performed_at

        else
          say 'Unknown. Run `troo refresh all`.'

        end
      end

      desc 'config',
           'Show the current configuration.'
      def config
        say heading('Current configuration:')
        say Troo.configuration.view
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

      desc 'add [board|list|card|comment] (<id>) (<value>)',
           'Add board, list, card or comment.'
      subcommand :add, CLI::Add

      desc 'default [board|list|card] <id>',
           'Set board, list or card to be default.'
      subcommand :default, CLI::Default

      desc 'refresh [all|board|list|card] (<id>)',
           'Refresh all local data or board, list or card with <id>.'
      subcommand :refresh, CLI::Refresh

      desc 'wizard', 'Become the wizard.'
      subcommand :wizard, CLI::Wizard

      desc 'move <card_id> <list_id> (<board_id>)',
           'Move card with <card_id> to list with <list_id> ' \
           'optionally to another board with <board_id>.'
      def move(card_id, list_id, board_id = nil)
        say Commands::Move::Card.dispatch(card_id, list_id, board_id)
      end

      private

      def heading(text = '')
        [Esc.yellow, Esc.underline, text, Esc.reset].join
      end
    end
  end
end
