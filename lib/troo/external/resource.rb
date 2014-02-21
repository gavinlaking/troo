module Troo
  module External
    class Resource
      attr_reader :external_id

      class << self
        def fetch(external_id, options = {})
          new(external_id, options).persist
        end
      end

      def initialize(external_id, options = {})
        @external_id = external_id
        @options     = options
      end

      private

      def resources
        @resources ||= API::Client.perform(parameters)
      end

      def options
        defaults.merge!(@options)
      end

      def defaults
        {}
      end

      def parameters
        {
          verb:          :get,
          endpoint:      nil,
          interpolation: interpolation,
          query:         {},
          model:         model
        }.merge!(resource_parameters)
      end

      def resource_parameters
        case options.fetch(:mode)
        when :all    then all
        when :board  then by_board_id
        when :list   then by_list_id
        when :card   then by_card_id
        when :member then by_member_id
        end
      end

      def interpolation
        { external_id: external_id }
      end
    end
  end
end
