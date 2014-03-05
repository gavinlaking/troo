module Troo
  module Decorators
    class Resource
      #include DecoratorHelpers

      def initialize(klass, options = {})
        @klass, @options = klass, options
      end

      def title
        [
          default,
          brackets(klass.id),
          highlight(name, options)
        ].join(' ')
      end

      def default
        klass.default? ? ' * ' : '   '
      end

      def id_str
        highlight(brackets(klass.id.to_s) + ' ', options)
      end

      def name
        (klass.name && klass.name.chomp) || 'N/A'
      end

      def board
        klass.board.decorator(options).short
      end

      def list
        klass.list.decorator(options).short
      end

      def lists(alt_options = {})
        klass.lists.map { |list| list.decorator(alt_options) }
      end

      def cards(alt_options = {})
        klass.cards.map { |card| card.decorator(alt_options) }
      end

      private

      attr_reader :klass, :options

      def options
        defaults.merge!(@options)
      end

      def defaults
        {
          ansicolor: true,
          colour:    nil,
          underline: nil,
        }
      end

      def brackets(value)
        [
          '(', value, ')'
        ].join
      end

      def highlight(value, options = defaults)
        if options.fetch(:ansicolor)
          [
            options.fetch(:colour),
            options.fetch(:underline),
            value,
            Esc.reset
          ].join
        else
          value
        end
      end
    end
  end
end
