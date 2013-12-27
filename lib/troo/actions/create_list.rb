module Troo
  class CreateList
    def initialize(board, name)
      @board = board
      @name  = name
    end

    def self.for(board, name)
      new(board, name).perform
    end

    def perform
      update_lists
    end

    private
    attr_reader :board, :name

    def update_lists
      return Troo::ListPersistence.for(create_list) if create_list
      false
    end

    def create_list
      @list ||= Trello::List.create(attributes)
    rescue Trello::Error
      false
    end

    def attributes
      {
        name:     name,
        board_id: board.external_board_id
      }
    end
  end
end
