module Troo
  module Decorators
    class List
      include DecoratorHelpers

      def initialize(list, options = {})
        @list = list
        @options = options
      end

      def short
        [default_str, id_str, name_str].join + "\n"
      end

      def name_str
        highlight(name, options)
      end

      def default_str
        default.center(3)
      end

      def id_str
        highlight(brackets(id) + ' ', options).rjust(6)
      end

      def name
        (list.name && list.name.chomp) || 'N/A'
      end

      def default
        list.default? ? '*' : ''
      end

      def id
        list.id.to_s
      end

      def cards(alt_options = {})
        list.cards.map { |card| card.decorator(alt_options) }
      end

      private
      attr_reader :list

      def options
        defaults.merge!(@options)
      end

      def defaults
        {
          ansicolor: true,
          colour:    Esc.green,
          underline: Esc.underline
        }
      end
    end
  end
end
