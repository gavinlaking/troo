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
      create_local
    end

    private
    attr_reader :name, :description

    def create_local
      if create_remote
        Persistence::Board.for(create_remote)
        # refresh for lists
      else
        false
      end
    end

    def create_remote
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
