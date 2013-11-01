module Trlo
  class MoveCard
    def initialize(card_id, list_id = nil)
      @card_id = card_id
      @list_id = list_id
    end

    def self.with(card_id, list_id = nil)
      new(card_id, list_id).move
    end

    def move
      if list_id.nil?
        ListPresenter.all(card.board_id)
        @list_id = ask("Destination list?: ") # mutable
        # MoveCard.with(card_id, list_id)     # immutable
      end
      card.move_to_list(list)
    end

    private
    attr_reader   :card_id
    attr_accessor :list_id

    def list
      Trello::List.find(list_id)
    end

    def card
      @card ||= Trello::Card.find(card_id)
    end
  end
end

