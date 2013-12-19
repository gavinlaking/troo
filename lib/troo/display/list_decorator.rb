module Troo
  class ListDecorator
    def initialize(list)
      @list = list
    end

    def short
      [current.center(3), id.rjust(6), name].join(" ") + "\n"
    end

    def name
      list.name
    end

    def current
      list.current? ? "*" : ""
    end

    def id
      brackets(list.id)
    end

    private
    attr_reader :list

    def brackets(value)
      "(#{value})"
    end
  end
end
