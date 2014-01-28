module Troo
  class CreateBoard
    class << self
      def with(name, description = nil)
        new(name, description).perform
      end
    end

    def initialize(name, description = nil)
      @name        = name
      @description = description
    end

    def perform
      update_boards
    end

    private
    attr_reader :name, :description

    def update_boards
      return BoardPersistence.for(create_board) if create_board
      false
    end

    def create_board
      @board ||= Trello::Board.create(attributes)
    rescue Trello::InvalidAccessToken
      raise Troo::InvalidAccessToken
    rescue Trello::Error
      false
    end

    def attributes
      {
        name:        name,
        description: description
      }
    end
  end
end
