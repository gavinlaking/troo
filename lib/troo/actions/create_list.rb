module Troo
  class CreateList
    def initialize(board_id, name = nil)
      @board_id = board_id
      @name     = name
    end

    def self.for(board_id, name = nil)
      new(board_id, name).create
    end

    def create
      Trello::List.create(attributes)
      self
    end

    def board_name
      board.name
    end

    def external_board_id
      board.external_board_id
    end

    def name
      @name ||= user_input
    end

    private
    attr_reader :board_id

    def board
      @board ||= Troo::BoardRetrieval.retrieve(board_id)
    end

    def attributes
      {
        name:     name,
        board_id: external_board_id
      }
    end

    def user_input
      Input.get(board_id)
    end
  end
end
