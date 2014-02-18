module Troo
  class MoveCard
    class << self
      def with(card, list, board = nil)
        new(card, list, board).perform
      end
    end

    def initialize(card, list, board = nil)
      @card, @list, @board = card, list, board
    end

    def perform
      update_cards
    end

    private

    attr_reader :card, :list, :board

    def update_cards
      return Persistence::Card.with_collection(resource) if resource
      false
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
      return :move_card_board if board
      :move_card_list
    end

    def interpolation
      { external_id: card.external_card_id }
    end

    def query
      return { id: board.external_board_id } if board
             { id: list.external_list_id }
    end
  end
end
