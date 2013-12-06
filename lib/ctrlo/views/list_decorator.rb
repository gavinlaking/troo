module Ctrlo
  class ListDecorator
    def initialize(list)
      @list = list
    end

    def as_view
      Template.parse(self)
    end

    def formatted_row
      [list_id, list_name].join
    end

    def template_file
      "/list_decorator.erb"
    end

    private
    attr_reader :list

    def list_name
      [ Esc.yellow, list.name, Esc.reset ].join
    end

    def list_id
      [ Esc.green, list_idstr, Esc.reset ].join
    end

    def list_idstr
      brackets(list.id.to_s).ljust(6)
    end

    def brackets(string = nil)
      "(" + string + ")"
    end
  end
end
