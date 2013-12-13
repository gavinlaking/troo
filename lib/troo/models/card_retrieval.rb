module Troo
  class CardRetrieval
    def initialize(id = nil)
      @id = id
    end

    def self.retrieve(id = nil)
      new(id).retrieve
    end

    def retrieve
      all || by_id || by_short_id || by_external_id || remote
    end

    private
    attr_reader :id

    def all
      return all_cards unless id
      nil
    end

    def all_cards
      Troo::Card.all
    end

    def by_id
      Troo::Card.get(id)
    end

    def by_short_id
      Troo::Card.first(short_id: id)
    end

    def by_external_id
      Troo::Card.first(external_card_id: id)
    end

    def remote
      ExternalCard.fetch(id, { mode: :card }).first
    end
  end
end
