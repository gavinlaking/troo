module Troo
  module Remote
    module Persistence
      class Board
        class << self
          def with(name, description = nil)
            new(name, description).create_local
          end
        end

        def initialize(name, description = nil)
          @name        = name
          @description = description
        end

        def create_local
          return Troo::Persistence::Local
            .with_collection(resource).first if any?
          false
        end

        private

        attr_reader :name, :description

        def any?
          resource.any?
        end

        def resource
          @resource ||= API::Client.perform(parameters)
        end

        def parameters
          {
            verb:          :post,
            endpoint:      :create_board,
            interpolation: {},
            query:         query,
            model:         Remote::Board
          }
        end

        def query
          {
            name: name,
            desc: description
          }
        end
      end
    end
  end
end
