module Troo
  class MoveCard
    def initialize(card_id, list_id)
      @card_id = card_id
      @list_id = list_id
    end

    def self.with(card_id, list_id)
      new(card_id, list_id).move
    end

    def move
      Trello::Card.new.
        update_fields({ 'id' => external_card_id }).
        move_to_list(destination_list_id)
      self
    end

    def source_list_id
      card.external_list_id
    end

    def source_list_name
      card.list.name
    end

    def destination_list_id
      destination_list.external_list_id
    end

    def destination_list_name
      destination_list.name
    end

    def external_card_id
      card.external_card_id
    end

    private
    attr_reader :card_id, :list_id

    def destination_list
      @list ||= Troo::ListRetrieval.retrieve(list_id)
    end

    def card
      @card ||= Troo::CardRetrieval.retrieve(card_id)
    end
  end
end
