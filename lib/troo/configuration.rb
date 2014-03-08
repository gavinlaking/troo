module Troo
  class Preference
    include Virtus.value_object

    values do
      attribute :label, String
      attribute :value, String
    end

    class << self
      def view(parameters)
        new(parameters).view
      end
    end

    def view
      [formatted_label, value].join(' ')
    end

    private

    def formatted_label
      (label + ':').rjust(25, ' ')
    end
  end

  class Configuration
    include Virtus.value_object

    values do
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
      def load(file, env)
        new(YAML.load_file(file)[env.to_s])
      end
    end

    def view
      attributes.map do |label, value|
        Preference.view(label: label, value: value)
      end.join("\n")
    end
  end
end
