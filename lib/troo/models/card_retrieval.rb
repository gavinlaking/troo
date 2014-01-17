module Troo
  class CardRetrieval
    class << self
      def all
        Troo::Card.all
      end

      def default
        new.retrieve
      end

      def retrieve(id = nil)
        new(id).retrieve
      end
    end

    def initialize(id = nil)
      @id = id
    end

    def retrieve
      return default unless id
      by_short_id || by_id || by_external_id || remote
    end

    private
    attr_reader :id

    def default
      Troo::Card.default
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
      External::Card.fetch(id, { mode: :card }).first
    end
  end
end
