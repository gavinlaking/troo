module Troo
  module Remote
    module Persistence
      class List
        class << self
          def with(external_board_id, name)
            new(external_board_id, name).perform
          end
        end

        def initialize(external_board_id, name)
          @external_board_id = external_board_id
          @name              = name
        end

        def perform
          create_local
        end

        private

        attr_reader :external_board_id, :name

        def create_local
          return Troo::Persistence::Resource
            .with_collection(resource).first if any?
          false
        end

        def any?
          resource.any?
        end

        def resource
          @resource ||= API::Client.perform(parameters)
        end

        def parameters
          {
            verb:          :post,
            endpoint:      :create_list,
            interpolation: {},
            query:         query,
            model:         Remote::List
          }
        end

        def query
          {
            name:     name,
            board_id: external_board_id
          }
        end
      end
    end
  end
end
