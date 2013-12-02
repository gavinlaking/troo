module Ctrlo
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
        FindLists.for(card.board_id)
        @list_id = ask("Destination list?: ") # mutable
        # MoveCard.with(card_id, list_id)     # immutable
      end
      card.move_to_list(FindList.with(list_id))
    end

    private
    attr_reader   :card_id
    attr_accessor :list_id

    def card
      @card ||= FindCard.with(card_id)
    end
  end
end
