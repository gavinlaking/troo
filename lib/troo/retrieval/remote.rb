module Troo
  module Retrieval
    class Remote
      attr_reader :external_id

      class << self
        # @param  []
        # @param  []
        # @param  []
        # @return []
        def fetch(klass, external_id, options = {})
          new(klass, external_id, options).fetch
        end
      end

      # @param  []
      # @param  []
      # @param  []
      # @return []
      def initialize(klass, external_id, options = {})
        @klass       = klass
        @external_id = external_id
        @options     = options
      end

      # @return []
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

      def persist
        @persisted ||= Troo::Persistence::Local
          .with_collection(resources)
      end

      def resources
        @resources ||= API::Client.perform(parameters)
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
        modes.fetch(mode)
      end

      def modes
        {
          all:    klass.all,
          board:  klass.by_board_id,
          list:   klass.by_list_id,
          card:   klass.by_card_id,
          member: klass.by_member_id,
          none:   {}
        }
      end

      def mode
        options.fetch(:mode, :none)
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

      def interpolation
        { external_id: external_id }
      end
    end
  end
end
