module Troo
  class ListDecorator
    include DecoratorHelpers

    def initialize(list, options = {})
      @list = list
      @options = options
    end

    def short
      [current_str, id_str, name_str].join + "\n"
    end

    def name_str
      highlight(name, highlight_options)
    end

    def current_str
      current.center(3)
    end

    def id_str
      highlight(brackets(id) + " ", highlight_options).rjust(6)
    end

    def name
      (list.name && list.name.chomp) || "N/A"
    end

    def current
      list.current? ? "*" : ""
    end

    def id
      list.id.to_s
    end

    private
    attr_reader :list

    def options
      defaults.merge!(@options)
    end

    def defaults
      { ansicolor: true }
    end

    def highlight_options
      { colour: Esc.green, underline: Esc.underline }
    end
  end
end
