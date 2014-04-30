module Troo
  module CLI
    class Wizard < ThorFixes
      package_name 'wizard'
      default_task :start

      # @return [String]
      desc 'start', 'Run the configuration wizard to get started.'
      def start
        say Troo::Formatter.wordwrap(welcome_message)

        step_zero!

        say Troo::Formatter.wordwrap(step_one_message)
        step_one!

        say Troo::Formatter.wordwrap(step_two_message)

        proceed?
        step_two!

        say 'All done! Run `troo` for further commands.'
      end

      private

      def connect_url(api_key)
        "https://trello.com/1/connect?key=#{api_key}" \
        "&name=troo&response_type=token&scope=read,write"
      end

      def generate_url
        'https://trello.com/1/appKey/generate'
      end

      def config
        @config ||= Troo::Configuration.new
      end

      def proceed?
        raise ConfigurationAborted unless yes?(user_input('Proceed?'))
      end

      def step_zero!
        if destination_exists?
          say "A configuration file already exists.\n"

          raise ConfigurationAborted unless yes?(user_input('Overwrite?'))
        end

        copy_configuration

        say "A configuration file was created.\n"
      end

      def step_one!
        Launchy.open(generate_url)
        config.api_key   = ask(user_input('Key:'))
        config.api_token = ask(user_input('Secret:'))
      end

      def step_two!
        Launchy.open(connect_url(config.api_key))
        config.api_oauth_token = ask(user_input('Token:'))
        config.save(Dir.home + '/.trooconf', 'default')
      end

      def welcome_message
        "Welcome to Troo. This wizard will create a configuration file " \
        "in your home directory and help you configure your API credentials " \
        "for Trello.\n\n"
      end

      def step_one_message
        "First, you'll need to sign in " \
        "to Trello in the normal way. Copy the API key and paste "   \
        "when prompted, then do the same for the secret.\n"
      end

      def step_two_message
        "Thank you. You must now allow this application to use "     \
        "Trello account. Copy and paste the token when prompted.\n"
      end

      def user_input(value)
        [Esc.yellow, value, Esc.reset].join
      end

      def copy_configuration
        FileUtils.cp(source, destination)
      end

      def destination_exists?
        File.exist?(destination)
      end

      def destination
        Dir.home + '/.trooconf'
      end

      def source
        File.dirname(__FILE__) + '/../../../config/trooconf.yml'
      end
    end
  end
end
