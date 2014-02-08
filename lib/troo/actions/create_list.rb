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
      create_local
    end

    private

    attr_reader :board, :name

    def create_local
      return Persistence::List.for(create_remote) if create_remote
      false
    end

    def create_remote
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
