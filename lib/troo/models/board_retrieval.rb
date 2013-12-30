module Troo
  class BoardRetrieval
    def initialize(id = nil)
      @id = id
    end

    def self.all
      Troo::Board.all
    end

    def self.current
      new.retrieve
    end

    def self.retrieve(id = nil)
      new(id).retrieve
    end

    def retrieve
      return current unless id
      by_id || by_external_id || remote
    end

    private
    attr_reader :id

    def current
      Troo::Board.current
    end

    def by_id
      Troo::Board[id]
    end

    def by_external_id
      Troo::Board.first(external_board_id: id)
    end

    def remote
      ExternalBoard.fetch(id).first
    end
  end
end
