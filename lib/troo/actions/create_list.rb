module Troo
  class CreateList
    class << self
      def for(board, name)
        new(board, name).perform
      end
    end

    def initialize(board, name)
      @board = board
      @name  = name
    end

    def perform
      update_lists
    end

    private
    attr_reader :board, :name

    def update_lists
      return Persistence::List.for(create_list) if create_list
      false
    end

    def create_list
      @list ||= Trello::List.create(attributes)
    rescue Trello::InvalidAccessToken
      raise Troo::InvalidAccessToken
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
