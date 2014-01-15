module Troo
  class BoardRetrieval
    class << self
      def all
        Troo::Board.all
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
      by_id || by_external_id || remote
    end

    private
    attr_reader :id

    def default
      Troo::Board.default
    end

    def by_id
      Troo::Board[id]
    end

    def by_external_id
      Troo::Board.first(external_board_id: id)
    end

    def remote
      External::Board.fetch(id).first
    end
  end
end
