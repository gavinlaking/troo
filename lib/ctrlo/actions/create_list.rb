module Ctrlo
  class CreateList
    attr_reader :name

    def initialize(board_id, name = nil)
      @board_id = board_id
      @name     = name
    end

    def self.for(board_id, name = nil)
      new(board_id, name).create
    end

    def create
      ProxyList.create(attributes)
      self
    end

    def external_board_id
      @external_board_id ||= Ctrlo::Board.retrieve(board_id).external_board_id
    end

    private
    attr_reader :board_id

    def attributes
      {
        name:     name,
        board_id: external_board_id
      }
    end

    def name
      @name || user_input
    end

    def user_input
      Input.get(board_id)
    end

  end
end
