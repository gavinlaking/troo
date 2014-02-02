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
      create_local_board
    end

    private
    attr_reader :name, :description

    def create_local_board
      if create_remote_board
        Persistence::Board.for(create_remote_board)
        # refresh for lists
      else
        false
      end
    end

    def create_remote_board
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
