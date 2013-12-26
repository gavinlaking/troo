module Troo
  class BoardRetrieval
    def initialize(id = nil)
      @id = id
    end

    def self.current
      Troo::Board.current
    end

    def self.retrieve(id = nil)
      new(id).retrieve
    end

    def retrieve
      all || by_id || by_external_id || remote
    end

    private
    attr_reader :id

    def all
      return all_boards unless id
      nil
    end

    def all_boards
      Troo::Board.all
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
