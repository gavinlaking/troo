module Trlo
  class ExternalBoard
    def initialize(external_board_id = nil)
      @external_board_id = external_board_id
    end

    def self.request(external_board_id = nil)
      new(external_board_id).request
    end

    def request
      collection? ? collection : singular
    end

    private
    attr_reader :external_board_id

    def collection
      Trello::Board.all
    rescue Trello::Error => e
      puts e.message
      exit 1
    end

    def singular
      [Trello::Board.find(external_board_id)]
    rescue Trello::Error => e
      puts e.message
      exit 1
    end

    def collection?
      external_board_id.nil?
    end
  end
end
