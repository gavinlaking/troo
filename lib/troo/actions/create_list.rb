module Troo
  class CreateList
    def initialize(board_id, name)
      @board_id = board_id
      @name     = name
    end

    def self.for(board_id, name)
      new(board_id, name).perform
    end

    def perform
      update_lists
    end

    private
    attr_reader :board_id, :name

    def update_lists
      return Troo::ListPersistence.for(create_list) if create_list
      false
    end

    def create_list
      @list ||= Trello::List.create(attributes)
    rescue Trello::Error
      false
    end

    def board
      @board ||= Troo::BoardRetrieval.retrieve(board_id)
    end

    def attributes
      {
        name:     name,
        board_id: board.external_board_id
      }
    end
  end
end
