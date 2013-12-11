module Ctrlo
  class ListDecorator
    def initialize(list)
      @list = list
    end

    def as_view
      Template.parse(self, "/../views/list.erb")
    end

    def as_list_row
      [list_id, list_name].join
    end

    def short
      print Esc.underline + Esc.yellow
      print list_id
      print Esc.reset
      print " "
      print list_name
      print "\n"
    end

    private
    attr_reader :list

    def list_name
      if list.name
        list.name.chomp
      else
        "N/A"
      end
    end

    def list_id
      list.id.to_s
    end
  end
end
