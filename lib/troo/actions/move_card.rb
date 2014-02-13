module Troo
  class MoveCard
    class << self
      def with(card, list, board = nil)
        new(card, list, board).perform
      end
    end

    def initialize(card, list, board = nil)
      @card  = card
      @list  = list
      @board = board
    end

    def perform
      return update_cards if move
      false
    end

    private

    attr_reader :card, :list, :board

    def update_cards
      #Troo::External::Card.fetch(card.external_board_id)
    end

    def move
      if board
        move_card
      else
        move_card_to_board
      end
    end

    def move_card
      Trello::Card.new
        .update_fields('id' => card.external_card_id)
        .move_to_list(list.external_list_id)
    rescue Trello::InvalidAccessToken
      raise Troo::InvalidAccessToken
    rescue Trello::Error
      false
    end

    def move_card_to_board
      Trello::Card.new
        .update_fields('id' => card.external_card_id)
        .move_to_board(proxy_board, proxy_list)
    rescue Trello::InvalidAccessToken
      raise Troo::InvalidAccessToken
    rescue Trello::Error
      false
    end

    def proxy_board
      Trello::Board.new.update_fields('id' => board.external_board_id)
    end

    def proxy_list
      Trello::List.new.update_fields('id' => list.external_list_id)
    end
  end
end
