module Ctrlo
  class BoardRetrieval
    def initialize(id = nil)
      @id = id
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
      Ctrlo::Board.all
    end

    def by_id
      Ctrlo::Board.get(id)
    end

    def by_external_id
      Ctrlo::Board.first(external_board_id: id)
    end

    def remote
      ExternalBoard.fetch(id).first
    end
  end
end
