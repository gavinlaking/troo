module Troo
  module Remote
    module Persistence
      class MoveCard
        class << self
          def with(external_card_id,
                   external_list_id,
                   external_board_id = nil)
            new(external_card_id, external_list_id, external_board_id)
              .perform
          end
        end

        def initialize(external_card_id,
                       external_list_id,
                       external_board_id = nil)
          @external_card_id  = external_card_id
          @external_list_id  = external_list_id
          @external_board_id = external_board_id
        end

        def perform
          update_cards
        end

        private

        attr_reader :external_card_id,
                    :external_list_id,
                    :external_board_id

        def update_cards
          return Troo::Persistence::Local
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
            verb:          :put,
            endpoint:      endpoint,
            interpolation: interpolation,
            query:         query,
            model:         Remote::Card
          }
        end

        def endpoint
          return :move_card_board if external_board_id
          :move_card_list
        end

        def interpolation
          { external_id: external_card_id }
        end

        def query
          return board_query if external_board_id
          list_query
        end

        def board_query
          {
            value:  external_board_id,
            idList: external_list_id
          }
        end

        def list_query
          {
            value: external_list_id
          }
        end
      end
    end
  end
end
