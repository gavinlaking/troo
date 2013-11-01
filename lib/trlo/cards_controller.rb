module Trlo
  class CardsController
    def initialize(options, arguments)
      @options   = options
      @arguments = arguments
    end

    def self.dispatch!(options, arguments)
      new(options, arguments).dispatch
    end

    def dispatch
      id = arguments.first
      options.each do |option|
        case option
        when :all
          CardPresenter.all(id)
        when :create
          puts "Not implemented yet."
        when :delete
          puts "Not implemented yet."
        when :show
          puts "Not implemented yet."
        when :comment
          CreateComment.for(id)
        when :move
          puts "Not implemented yet."
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
