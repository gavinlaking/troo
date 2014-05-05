module Troo
  class Configuration
    include Virtus.model

    attribute :api_key
    attribute :api_token
    attribute :api_oauth_token
    attribute :api_oauth_token_secret
    attribute :allow_remote, Boolean, default: true
    attribute :logs,         Boolean, default: false
    attribute :name,         String,  default: 'My Default Configuration'
    attribute :api_url,      String,  default: 'https://api.trello.com/1'
    attribute :database,     Integer, default: 1

    class << self
      def load(file, env)
        new(YAML.load_file(file)[env])
      end
    end

    def save(file, env)
      return true if File.open(file, 'w') do |file|
        file.write configuration_yaml(env)
      end
      false
    end

    def view
      attributes.map do |label, value|
        Preference.view(label: label, value: value)
      end.join("\n")
    end

    private

    def configuration_yaml(env = 'default')
      { env => self.attributes }.to_yaml
    end
  end
end
