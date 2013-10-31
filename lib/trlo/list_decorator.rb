module Trlo
  class ListDecorator
    def initialize(list)
      @list = list
    end

    def id
      list.id
    end

    def name
      list.name
    end

    def to_hash
      { id: id, name: name }
    end

    private
    attr_reader :list
  end
end