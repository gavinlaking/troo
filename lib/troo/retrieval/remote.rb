module Troo
  module Retrieval
    class Remote
      attr_reader :external_id

      class << self
        def fetch(klass, external_id, options = {})
          new(klass, external_id, options).fetch
        end
      end

      def initialize(klass, external_id, options = {})
        @klass       = klass
        @external_id = external_id
        @options     = options
      end

      def fetch
        return []        if none?
        return persist   if persist?
               resources
      end

      private

      attr_reader :klass

      def none?
        resources.empty?
      end

      def resources
        @resources ||= API::Client.perform(parameters)
      end

      def persist
        @persisted ||= Troo::Persistence::Local
          .with_collection(resources)
      end

      def persist?
        options.fetch(:persist)
      end

      def options
        remote_options.merge!(@options)
      end

      def remote_options
        defaults.merge!(klass.remote_options)
      end

      def defaults
        { mode: :none, persist: true }
      end

      def parameters
        {
          verb:          :get,
          endpoint:      nil,
          interpolation: interpolation,
          query:         {},
          model:         klass
        }.merge!(resource_parameters)
      end

      def resource_parameters
        case options.fetch(:mode)
        when :all    then klass.all
        when :board  then klass.by_board_id
        when :list   then klass.by_list_id
        when :card   then klass.by_card_id
        when :member then klass.by_member_id
        else
          {}
        end
      end

      def interpolation
        { external_id: external_id }
      end
    end
  end
end
