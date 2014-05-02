module Troo
  module Remote
    module Persistence
      class Card
        class << self
          # @param  [String]
          # @param  [String, NilClass]
          # @param  [String, NilClass]
          # @return [Troo::Card, FalseClass]
          def with(external_list_id, name = nil, description = nil)
            new(external_list_id, name, description).create_local
          end
        end

        # @param  [String]
        # @param  [String, NilClass]
        # @param  [String, NilClass]
        # @return [Troo::Remote::Persistence::Card]
        def initialize(external_list_id, name = nil, description = nil)
          @external_list_id = external_list_id
          @name             = name
          @description      = description
        end

        # @return [Troo::Card, FalseClass]
        def create_local
          return Troo::Persistence::Local
            .with_collection(resource).first if any?
          false
        end

        private

        attr_reader :external_list_id, :name, :description

        def any?
          resource.any?
        end

        def resource
          @resource ||= API::Client.perform(parameters)
        end

        def parameters
          {
            verb:          :post,
            endpoint:      :create_card,
            interpolation: {},
            query:         query,
            model:         Remote::Card
          }
        end

        def query
          {
            name:    name,
            list_id: external_list_id,
            desc:    description
          }
        end
      end
    end
  end
end
