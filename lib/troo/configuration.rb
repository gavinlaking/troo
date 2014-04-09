module Troo
  class Configuration
    include Virtus.value_object

    values do
      attribute :name
      attribute :api_url
      attribute :api_key
      attribute :api_token
      attribute :api_oauth_token
      attribute :api_oauth_token_secret
      attribute :database
      attribute :allow_remote, Boolean, default: true
      attribute :logs,         Boolean, default: false
    end

    class << self
      # @param  []
      # @param  [String]
      # @return []
      def load(file, env)
        new(YAML.load_file(file)[env])
      end
    end

    # @return []
    def view
      attributes.map do |label, value|
        Preference.view(label: label, value: value)
      end.join("\n")
    end
  end
end
