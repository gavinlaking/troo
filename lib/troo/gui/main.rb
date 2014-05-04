module Troo
  module GUI
    class Main
      include Vedeu

      interface :main,    {
                  y:          1,
                  x:          1,
                  height:     23,
                  colour: {
                    foreground: '#ffffff',
                    background: '#000000'
                  },
                  cursor:     false,
                  z:          0 }
      interface :status,  {
                  y:          24,
                  x:          1,
                  height:     1,
                  colour: {
                    foreground: '#00ff00',
                    background: '#003300'
                  },
                  cursor:     false,
                  z:          1 }
      interface :command, {
                  y:          25,
                  x:          1,
                  height:     1,
                  colour: {
                    foreground: '#ffffff',
                    background: '#000000'
                  },
                  cursor:     true,
                  z:          1 }

      command :move_card, {
                entity: Commands::Move::Card,
                keyword: '',
                keypress: '',
                arguments: [] }

      command :refresh_all, {
                entity: Commands::RefreshAll,
                keyword: '',
                keypress: '',
                arguments: [] }

      command 'show_boards', {
                entity: Commands::ShowBoards,
                keyword: 'boards',
                keypress: 'b',
                arguments: [{ gui: true }] }

      command :show_comments, {
                entity: Commands::ShowComments,
                keyword: '',
                keypress: '',
                arguments: [] }

      command :add, {
                entity: Commands::Add,
                keyword: '',
                keypress: '',
                arguments: [] }

      command :default, {
                entity: Commands::Default,
                keyword: '',
                keypress: '',
                arguments: [] }

      command :refresh, {
                entity: Commands::Refresh,
                keyword: '',
                keypress: '',
                arguments: [] }

      command :show, {
                entity: Commands::Show,
                keyword: '',
                keypress: '',
                arguments: [] }

      command :status, {
                entity: Commands::Status,
                keyword: '',
                keypress: '',
                arguments: [] }

      command :exit, {
                entity: Vedeu::Exit,
                keyword: 'exit',
                keypress: 'q',
                arguments: [] }

      class << self
        def start(argv, options = {})
          new(argv, options = {}).bootstrap
        end
      end

      def initialize(argv, options = {})
        @argv, @options = argv, options
      end

      def bootstrap
        Vedeu::Launcher.new(argv).execute!
      end

      private

      attr_reader :argv, :options
    end
  end
end
