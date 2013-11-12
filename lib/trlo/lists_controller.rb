module Trlo
  class ListsController
    def initialize(options, arguments)
      @options   = options
      @arguments = arguments
    end

    def self.dispatch!(options, arguments)
      new(options, arguments).dispatch
    end

    def dispatch
      options.each do |option|
        case option
        when :all
          board_id = arguments[0]
          Output.new(FindLists.for(board_id)).list_table
        end
      end
    end

    private
    attr_reader :arguments

    def options
      @options.delete_if { |_, v| v.nil? }.keys
    end
  end
end

