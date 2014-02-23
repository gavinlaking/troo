module Troo
  module Remote
    module Retrieval
      class Resource
        attr_reader :external_id

        class << self
          def fetch(external_id, options = {})
            new(external_id, options).fetch
          end
        end

        def initialize(external_id, options = {})
          @external_id = external_id
          @options     = options
        end

        def fetch
          return []        if none?
          return persist   if persist?
                 resources
        end

        private

        def none?
          resources.empty?
        end

        def resources
          @resources ||= API::Client.perform(parameters)
        end

        def persist
          @persisted ||= Persistence::Resource.with_collection(resources)
        end

        def persist?
          options.fetch(:persist)
        end

        def options
          defaults.merge!(@options)
        end

        def defaults
          { persist: true }
        end

        def parameters
          {
            verb:          :get,
            endpoint:      nil,
            interpolation: interpolation,
            query:         {},
            model:         remote_model
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
end
