module Troo
  module CLI
    class Wizard < ThorFixes
      package_name 'wizard'
      default_task :start

      # @return [String]
      desc 'start', 'Run the configuration wizard to get started.'
      def start
        say "Welcome to Troo. This wizard will help you configure " \
            "your API credentials for Trello."
        say "First, you'll need to sign in to Trello in the normal " \
            "way."
        say "Copy the API key and paste when prompted, then do the " \
            "same for the secret."

        proceed? && step_one!

        say "Thank you. You must now allow this application to " \
            "use your Trello account. Copy and paste the token " \
            "when prompted."

        proceed? && step_two!

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
        raise ConfigurationAborted unless yes?('Proceed?')
      end

      def step_one!
        Launchy.open(generate_url)
        config.api_key   = ask('Key:')
        config.api_token = ask('Secret:')
      end

      def step_two!
        Launchy.open(connect_url(config.api_key))
        config.api_oauth_token = ask('Token: ')
        config.save(Dir.home + '/.trooconf', 'default')
      end
    end
  end
end
