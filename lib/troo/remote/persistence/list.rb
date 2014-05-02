module Troo
  module Remote
    module Persistence
      class List
        class << self
          # @param  [String]
          # @param  [String]
          # @return [Troo::List, FalseClass]
          def with(external_board_id, name)
            new(external_board_id, name).create_local
          end
        end

        # @param  [String]
        # @param  [String]
        # @return [Troo::Remote::Persistence::List]
        def initialize(external_board_id, name)
          @external_board_id = external_board_id
          @name              = name
        end

        # @return [Troo::List, FalseClass]
        def create_local
          return Troo::Persistence::Local
            .with_collection(resource).first if any?
          false
        end

        private

        attr_reader :external_board_id, :name

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
