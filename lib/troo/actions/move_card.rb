module Troo
  class MoveCard
    class << self
      def with(card, list)
        new(card, list).perform
      end
    end

    def initialize(card, list)
      @card = card
      @list = list
    end

    def perform
      return update_cards if move_card
      false
    end

    private

    attr_reader :card, :list

    def update_cards
      Troo::External::Card.fetch(card.external_board_id)
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
  end
end
