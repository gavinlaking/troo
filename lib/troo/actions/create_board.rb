module Troo
  class CreateBoard
    attr_reader :name

    def initialize(name, description = nil)
      @name        = name
      @description = description
    end

    def self.with(name, description = nil)
      new(name, description).create
    end

    def create
      Trello::Board.create(attributes)
      self
    end

    def description
      @description ||= description_input
    end

    private

    def attributes
      {
        name:        name,
        description: description
      }
    end

    def description_input
      Input.get
    end
  end
end
