module Troo
  class Configuration
    include Virtus.value_object

    values do
      attribute :api_url
      attribute :api_key
      attribute :api_token
      attribute :api_oauth_token
      attribute :api_oauth_token_secret
      attribute :main_db
      attribute :test_db
    end

    class << self
      def load(file, env)
        new(YAML.load_file(file)[env.to_s])
      end
    end
  end
end
