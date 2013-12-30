module Troo
  class CardRetrieval
    def initialize(id = nil)
      @id = id
    end

    def self.all
      Troo::Card.all
    end

    def self.current
      new.retrieve
    end

    def self.retrieve(id = nil)
      new(id).retrieve
    end

    def retrieve
      return current unless id
      by_short_id || by_id || by_external_id || remote
    end

    private
    attr_reader :id

    def current
      Troo::Card.current
    end

    def by_id
      Troo::Card[id]
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
